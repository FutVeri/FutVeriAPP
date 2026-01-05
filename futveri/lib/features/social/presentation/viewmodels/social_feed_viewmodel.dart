import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:futveri/core/supabase/supabase_client.dart';
import 'package:futveri/features/social/domain/post.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:uuid/uuid.dart';

class SocialFeedState {
  final List<Post> posts;
  final bool isLoading;
  final String? errorMessage;

  SocialFeedState({
    this.posts = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  SocialFeedState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SocialFeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class SocialFeedNotifier extends Notifier<SocialFeedState> {
  @override
  SocialFeedState build() {
    // Initial load
    Future.microtask(() => loadPosts());
    return SocialFeedState(isLoading: true);
  }

  Future<void> loadPosts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      print('📢 SocialFeed: Loading posts from Supabase...');
      
      try {
        final sampleComment = await supabase.client.from('comments').select().limit(1);
        print('📢 DEBUG: Sample comment row: $sampleComment');
      } catch (e) {
        print('📢 DEBUG: Error fetching sample comment: $e');
      }
      
      // Try with join first
      final response = await supabase.client
          .from('posts')
          .select('*, users!scout_id(name)')
          .order('created_at', ascending: false);

      print('📢 SocialFeed: Raw response: $response');
      print('📢 SocialFeed: Got ${response.length} posts');

      final postsArr = (response as List).map((data) {
        // Handle different join response structures
        String scoutName = 'Unknown Scout';
        if (data['users'] != null) {
          if (data['users'] is Map) {
            scoutName = data['users']['name'] ?? 'Unknown Scout';
          } else if (data['users'] is List && data['users'].isNotEmpty) {
            scoutName = data['users'][0]['name'] ?? 'Unknown Scout';
          }
        }
        
        return Post(
          id: data['id'] as String,
          scoutId: data['scout_id'] as String,
          scoutName: scoutName,
          playerName: data['player_name'] as String,
          playerInfo: data['player_info'] as String,
          rating: (data['rating'] as num).toDouble(),
          comment: data['comment'] as String,
          imageUrls: List<String>.from(data['image_urls'] ?? []),
          likes: data['likes_count'] ?? 0,
          commentCount: data['comments_count'] ?? 0,
          createdAt: DateTime.parse(data['created_at'] as String),
        );
      }).toList();

      state = state.copyWith(posts: postsArr, isLoading: false);
      print('✅ SocialFeed: Posts state updated with ${postsArr.length} posts');
    } catch (e) {
      print('❌ SocialFeed Error: $e');
      // If join fails, try without join as fallback
      try {
        print('📢 SocialFeed: Retrying without JOIN...');
        final fallbackResponse = await supabase.client
            .from('posts')
            .select()
            .order('created_at', ascending: false);
        
        final user = supabase.auth.currentUser;
        List<String> userLikedPostIds = [];
        if (user != null) {
          final likesResponse = await supabase.client
              .from('likes')
              .select('post_id')
              .eq('user_id', user.id);
          userLikedPostIds = (likesResponse as List).map((l) => l['post_id'] as String).toList();
        }

        final postsArr = (fallbackResponse as List).map((data) {
          final postId = data['id'] as String;
          return Post(
            id: postId,
            scoutId: data['scout_id'] as String,
            scoutName: 'Scout', // Fallback name
            playerName: data['player_name'] as String,
            playerInfo: data['player_info'] as String,
            rating: (data['rating'] as num).toDouble(),
            comment: data['comment'] as String,
            imageUrls: List<String>.from(data['image_urls'] ?? []),
            likes: data['likes_count'] ?? 0,
            commentCount: data['comments_count'] ?? 0,
            createdAt: DateTime.parse(data['created_at'] as String),
            isLiked: userLikedPostIds.contains(postId),
          );
        }).toList();
        state = state.copyWith(posts: postsArr, isLoading: false);
      } catch (fallbackError) {
        print('❌ SocialFeed Fallback Error: $fallbackError');
        state = state.copyWith(isLoading: false, errorMessage: e.toString());
      }
    }
  }

  Future<void> toggleLike(String postId) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final postIndex = state.posts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final post = state.posts[postIndex];
    final wasLiked = post.isLiked;

    // Optimistic UI update
    final updatedPost = post.copyWith(
      isLiked: !wasLiked,
      likes: wasLiked ? post.likes - 1 : post.likes + 1,
    );
    final updatedPosts = List<Post>.from(state.posts);
    updatedPosts[postIndex] = updatedPost;
    state = state.copyWith(posts: updatedPosts);

    try {
      if (wasLiked) {
        // Unlike
        await supabase.client
            .from('likes')
            .delete()
            .eq('post_id', postId)
            .eq('user_id', user.id);
        
        // Decrement count - RPC missing
        // await supabase.client.rpc('decrement_post_likes', params: {'row_id': postId});
      } else {
        // Like
        await supabase.client.from('likes').insert({
          'post_id': postId,
          'user_id': user.id,
        });

        // Increment count - RPC missing
        // await supabase.client.rpc('increment_post_likes', params: {'row_id': postId});
      }
    } catch (e) {
      print('❌ Error toggling like: $e');
      // Rollback on error
      final rollbackPosts = List<Post>.from(state.posts);
      rollbackPosts[postIndex] = post;
      state = state.copyWith(posts: rollbackPosts);
    }
  }

  Future<bool> shareReport({
    required ScoutReport report,
    required String caption,
  }) async {
    print('📢 SocialFeed: Attempting to share report ${report.id}...');
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        print('❌ SocialFeed: User not logged in');
        throw Exception('Lütfen önce giriş yapın');
      }

      // Ensure we use snake_case keys as expected by the database
      final postData = {
        'id': const Uuid().v4(),
        'scout_id': user.id,
        'report_id': report.id,
        'player_name': report.playerName,
        'player_info': '${report.playerAge} yaş • ${report.playerPosition} • ${report.playerTeam}',
        'rating': report.overallRating,
        'comment': caption,
        'image_urls': report.imageUrls,
        'is_public': true,
        'likes_count': 0,
        'comments_count': 0,
      };

      print('📢 SocialFeed: Final data for Supabase: $postData');
      
      final response = await supabase.client
          .from('posts')
          .insert(postData)
          .select()
          .single();

      print('✅ SocialFeed: Successfully shared! Result ID: ${response['id']}');
      
      // Refresh feed in background
      loadPosts(); 
      
      return true;
    } catch (e) {
      print('❌ SocialFeed SHARING FAILED: $e');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

final socialFeedProvider = NotifierProvider<SocialFeedNotifier, SocialFeedState>(() {
  return SocialFeedNotifier();
});
