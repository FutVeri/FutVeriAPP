import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/social/presentation/viewmodels/post_detail_viewmodel.dart';
import 'package:futveri/features/social/presentation/widgets/comment_item_widget.dart';
import 'package:futveri/features/social/presentation/widgets/comment_input_widget.dart';
import 'package:futveri/features/social/presentation/widgets/player_ratings_sheet.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  final String postId;

  const PostDetailPage({
    super.key,
    required this.postId,
  });

  @override
  ConsumerState<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postDetailProvider(widget.postId));
    final notifier = ref.read(postDetailProvider(widget.postId).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Post'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.share2),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Header
                  _buildPostHeader(state.post.scoutName, state.post.createdAt),
                  Gap(16.h),

                  // Player Card
                  _buildPlayerCard(
                    state.post.playerName,
                    state.post.playerInfo,
                    state.post.rating,
                  ),
                  Gap(16.h),

                  // Analysis Text
                  Text(
                    state.post.comment,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      height: 1.6,
                    ),
                  ),
                  Gap(24.h),

                  // Like Button
                  _buildLikeButton(
                    state.post.isLiked,
                    state.post.likes,
                    notifier.toggleLike,
                  ),
                  Gap(24.h),

                  // Comments Section Header
                  Row(
                    children: [
                      Icon(
                        LucideIcons.messageSquare,
                        size: 18.sp,
                        color: AppTheme.textGrey,
                      ),
                      Gap(8.w),
                      Text(
                        'Comments (${state.post.commentCount})',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),

                  // Comments List
                  if (state.comments.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Text(
                          'No comments yet. Be the first to comment!',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.comments.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white.withOpacity(0.05),
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        return CommentItemWidget(
                          comment: state.comments[index],
                        );
                      },
                    ),
                  Gap(80.h), // Space for comment input
                ],
              ),
            ),
          ),

          // Comment Input (Fixed at bottom)
          CommentInputWidget(
            controller: _commentController,
            onChanged: notifier.updateCommentText,
            onSend: () {
              notifier.addComment();
              _commentController.clear();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostHeader(String scoutName, DateTime createdAt) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: Colors.white10,
          child: Icon(LucideIcons.user, size: 20.sp, color: Colors.white),
        ),
        Gap(12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scoutName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _getTimeAgo(createdAt),
              style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlayerCard(String playerName, String playerInfo, double rating) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => PlayerRatingsSheet(
            playerName: playerName,
            playerInfo: playerInfo,
            overallRating: rating,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, AppTheme.surfaceDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: rating >= 8
                ? AppTheme.primaryGreen.withOpacity(0.5)
                : AppTheme.secondaryBlue.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(LucideIcons.user, color: Colors.white24, size: 30.sp),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    playerInfo,
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: rating >= 8 ? AppTheme.primaryGreen : AppTheme.secondaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                rating.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton(bool isLiked, int likes, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isLiked
              ? AppTheme.primaryGreen.withOpacity(0.2)
              : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isLiked
                ? AppTheme.primaryGreen
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLiked ? LucideIcons.heart : LucideIcons.heart,
              size: 20.sp,
              color: isLiked ? AppTheme.primaryGreen : AppTheme.textGrey,
            ),
            Gap(8.w),
            Text(
              '$likes likes',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isLiked ? AppTheme.primaryGreen : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
