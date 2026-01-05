import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/features/social/presentation/widgets/feed_post_widget.dart';
import 'package:futveri/features/social/presentation/widgets/feed_filter_sheet.dart';
import 'package:futveri/features/social/presentation/viewmodels/social_feed_viewmodel.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:gap/gap.dart';

class SocialFeedPage extends ConsumerWidget {
  const SocialFeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialState = ref.watch(socialFeedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutVeri Feed'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.messageCircle),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search players, scouts...',
                      prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textGrey),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                Gap(12.w),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => const FeedFilterSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Icon(LucideIcons.filter, size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          
          // Feed List
          Expanded(
            child: socialState.isLoading 
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => ref.read(socialFeedProvider.notifier).loadPosts(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: socialState.posts.length,
                    itemBuilder: (context, index) {
                      final post = socialState.posts[index];
                      return FeedPostWidget(
                        postId: post.id,
                        scoutName: post.scoutName,
                        playerName: post.playerName,
                        playerInfo: post.playerInfo,
                        rating: post.rating,
                        comment: post.comment,
                        likes: post.likes,
                        commentCount: post.commentCount,
                        isLiked: post.isLiked,
                      );
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
