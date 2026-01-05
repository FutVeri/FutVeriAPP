import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/social/domain/post.dart';
import 'package:futveri/features/social/domain/comment.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:futveri/core/supabase/supabase_client.dart';
import 'package:uuid/uuid.dart';

// State for Post Detail
class PostDetailState {
  final Post? post;
  final ScoutReport? report;
  final List<Comment> comments;
  final bool isLoading;
  final bool isLoadingComments;
  final String newCommentText;
  final String? errorMessage;

  PostDetailState({
    this.post,
    this.report,
    this.comments = const [],
    this.isLoading = false,
    this.isLoadingComments = false,
    this.newCommentText = '',
    this.errorMessage,
  });

  PostDetailState copyWith({
    Post? post,
    ScoutReport? report,
    List<Comment>? comments,
    bool? isLoading,
    bool? isLoadingComments,
    String? newCommentText,
    String? errorMessage,
  }) {
    return PostDetailState(
      post: post ?? this.post,
      report: report ?? this.report,
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      newCommentText: newCommentText ?? this.newCommentText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ViewModel for Post Detail
class PostDetailViewModel extends Notifier<PostDetailState> {
  String? _postId;

  void setPostId(String postId) {
    _postId = postId;
  }

  @override
  PostDetailState build() {
    // If we have a postId, trigger loading
    if (_postId != null) {
      Future.microtask(() => loadPostAndComments());
    }
    return PostDetailState(isLoading: true);
  }

  Future<void> loadPostAndComments() async {
    if (_postId == null) return;
    
    // Safety check: ensure we are initialized
    // In Riverpod 2.x/3.x, if we got here from build via microtask, we are likely fine.
    
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // 1. Fetch Post with scout name
      final postResponse = await supabase.client
          .from('posts')
          .select('*, users!scout_id(name)')
          .eq('id', _postId!)
          .single();

      final postData = Post.fromJson(postResponse);

      // 1.1 Check if liked by current user
      final user = supabase.auth.currentUser;
      bool isLiked = false;
      if (user != null) {
        final likeCheck = await supabase.client
            .from('likes')
            .select()
            .eq('post_id', _postId!)
            .eq('user_id', user.id)
            .maybeSingle();
        isLiked = likeCheck != null;
      }

      final post = postData.copyWith(isLiked: isLiked);

      // 2. Fetch related ScoutReport if it exists
      ScoutReport? report;
      if (post.reportId != null) {
        final reportResponse = await supabase.client
            .from('scout_reports')
            .select()
            .eq('id', post.reportId!)
            .single();
        report = ScoutReport.fromJson(reportResponse);
      }

      // 3. Fetch Comments with user names
      final commentsResponse = await supabase.client
          .from('comments')
          .select('*, users!user_id(name)')
          .eq('post_id', _postId!)
          .order('created_at', ascending: false);

      final comments = (commentsResponse as List)
          .map((c) {
            if (c == (commentsResponse as List).first) {
              print('📢 DEBUG: Comment keys: ${c.keys.toList()}');
            }
            return Comment.fromJson(c);
          })
          .toList();

      state = state.copyWith(
        post: post,
        report: report,
        comments: comments,
        isLoading: false,
      );
    } catch (e) {
      print('❌ Error loading post detail: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'İçerik yüklenirken bir hata oluştu: $e',
      );
    }
  }

  Future<void> toggleLike() async {
    if (state.post == null || _postId == null) return;
    
    final user = supabase.auth.currentUser;
    if (user == null) {
      state = state.copyWith(errorMessage: 'Beğenmek için giriş yapmalısınız');
      return;
    }

    final wasLiked = state.post!.isLiked;
    final updatedPost = state.post!.copyWith(
      isLiked: !wasLiked,
      likes: wasLiked ? state.post!.likes - 1 : state.post!.likes + 1,
    );
    
    state = state.copyWith(post: updatedPost);

    try {
      if (wasLiked) {
        await supabase.client
            .from('likes')
            .delete()
            .eq('post_id', _postId!)
            .eq('user_id', user.id);
        
        // await supabase.client.rpc('decrement_post_likes', params: {'row_id': _postId!});
      } else {
        await supabase.client.from('likes').insert({
          'post_id': _postId,
          'user_id': user.id,
        });

        // await supabase.client.rpc('increment_post_likes', params: {'row_id': _postId!});
      }
    } catch (e) {
      print('❌ Error toggling like: $e');
      // Rollback
      state = state.copyWith(
        post: updatedPost.copyWith(
          isLiked: wasLiked,
          likes: wasLiked ? updatedPost.likes + 1 : updatedPost.likes - 1,
        ),
      );
    }
  }

  void updateCommentText(String text) {
    state = state.copyWith(newCommentText: text);
  }

  Future<void> addComment() async {
    final text = state.newCommentText.trim();
    if (text.isEmpty || state.post == null || _postId == null) return;

    final user = supabase.auth.currentUser;
    if (user == null) {
      state = state.copyWith(errorMessage: 'Yorum yapmak için giriş yapmalısınız');
      return;
    }

    state = state.copyWith(isLoadingComments: true);
    
    try {
      final commentId = const Uuid().v4();
      final commentData = {
        'id': commentId,
        'post_id': _postId,
        'user_id': user.id,
        'content': text,
        'created_at': DateTime.now().toIso8601String(),
      };

      await supabase.client.from('comments').insert(commentData);
      
      // Increment comment count atomically - RPC missing, skipping for now
      // await supabase.client.rpc('increment_post_comments', params: {'row_id': _postId!});

      // Refresh comments and clear input
      state = state.copyWith(newCommentText: '');
      await loadPostAndComments();
    } catch (e) {
      print('❌ Error adding comment: $e');
      state = state.copyWith(
        isLoadingComments: false,
        errorMessage: 'Yorum eklenirken hata oluştu: $e',
      );
    }
  }
}

// Manual cache to simulate family behavior with Notifier
final _postDetailProviders = <String, NotifierProvider<PostDetailViewModel, PostDetailState>>{};

NotifierProvider<PostDetailViewModel, PostDetailState> postDetailProvider(String postId) {
  return _postDetailProviders.putIfAbsent(
    postId,
    () => NotifierProvider<PostDetailViewModel, PostDetailState>(() {
      return PostDetailViewModel()..setPostId(postId);
    }),
  );
}
