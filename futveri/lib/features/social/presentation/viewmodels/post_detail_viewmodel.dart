import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/social/domain/post.dart';
import 'package:futveri/features/social/domain/comment.dart';

// State for Post Detail
class PostDetailState {
  final Post post;
  final List<Comment> comments;
  final bool isLoadingComments;
  final String newCommentText;

  PostDetailState({
    required this.post,
    this.comments = const [],
    this.isLoadingComments = false,
    this.newCommentText = '',
  });

  PostDetailState copyWith({
    Post? post,
    List<Comment>? comments,
    bool? isLoadingComments,
    String? newCommentText,
  }) {
    return PostDetailState(
      post: post ?? this.post,
      comments: comments ?? this.comments,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      newCommentText: newCommentText ?? this.newCommentText,
    );
  }
}

class PostDetailNotifier extends Notifier<PostDetailState> {
  late String _postId;

  @override
  PostDetailState build() {
    // This will be set by the provider
    return PostDetailState(
      post: _getMockPost(),
      comments: _getMockComments(),
    );
  }

  void setPostId(String postId) {
    _postId = postId;
  }

  void toggleLike() {
    final updatedPost = state.post.copyWith(
      isLiked: !state.post.isLiked,
      likes: state.post.isLiked ? state.post.likes - 1 : state.post.likes + 1,
    );
    state = state.copyWith(post: updatedPost);
  }

  void updateCommentText(String text) {
    state = state.copyWith(newCommentText: text);
  }

  void addComment() {
    if (state.newCommentText.trim().isEmpty) return;

    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user',
      userName: 'You',
      text: state.newCommentText,
      createdAt: DateTime.now(),
    );

    final updatedComments = [newComment, ...state.comments];
    final updatedPost = state.post.copyWith(
      commentCount: state.post.commentCount + 1,
    );

    state = state.copyWith(
      comments: updatedComments,
      post: updatedPost,
      newCommentText: '',
    );
  }

  Post _getMockPost() {
    return Post(
      id: '1',
      scoutId: 's1',
      scoutName: 'Ahmet Yılmaz',
      playerName: 'Semih Kılıçsoy',
      playerInfo: 'Beşiktaş • FW • 19 yo',
      rating: 8.5,
      comment: 'Incredible finishing ability for his age. Needs to improve decision making in tight spaces. His movement off the ball is exceptional and he has great potential to become a top striker in Europe.',
      imageUrls: [],
      likes: 124,
      commentCount: 15,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isLiked: false,
    );
  }

  List<Comment> _getMockComments() {
    return [
      Comment(
        id: '1',
        userId: 'u1',
        userName: 'Mehmet Demir',
        text: 'Great analysis! I agree about his decision making.',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Comment(
        id: '2',
        userId: 'u2',
        userName: 'Ayşe Kaya',
        text: 'He was amazing in the last match!',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      Comment(
        id: '3',
        userId: 'u3',
        userName: 'Can Öztürk',
        text: 'Do you think he can play in the Premier League?',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }
}

// Provider family to accept postId
final postDetailProvider = NotifierProvider.family<PostDetailNotifier, PostDetailState, String>(
  () => PostDetailNotifier(),
);
