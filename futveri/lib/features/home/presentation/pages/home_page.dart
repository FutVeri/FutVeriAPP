import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/player_search_card.dart';
import '../widgets/home_modules.dart';
import 'package:futveri/features/social/presentation/widgets/feed_post_widget.dart';
import 'package:futveri/features/social/presentation/viewmodels/social_feed_viewmodel.dart';
import 'package:futveri/features/social/presentation/widgets/feed_filter_sheet.dart';
import 'package:futveri/features/scout/presentation/viewmodels/scout_reports_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => const FeedFilterSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutVeri Analiz'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.filter),
            onPressed: () => _showFilterSheet(context),
          ),
          IconButton(
            icon: const Icon(LucideIcons.plusCircle),
            onPressed: () => context.push('/create-report'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SearchBarWidget(
              hintText: 'Oyuncu İsmini yaz...',
              onChanged: viewModel.updateSearchQuery,
              onClear: viewModel.clearSearch,
            ),
          ),
          
          // Results or Dashboard
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildBody(context, state, ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state, WidgetRef ref) {
    if (state.searchQuery.isEmpty) {
      return _buildFeedContent(context, ref);
    } else if (state.isSearching) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.searchResults.isEmpty) {
      return _buildNoResults();
    } else {
      return ListView.builder(
        itemCount: state.searchResults.length,
        itemBuilder: (context, index) {
          final player = state.searchResults[index];
          return PlayerSearchCard(
            player: player,
            onTap: () {
              context.push('/create-report');
            },
          );
        },
      );
    }
  }

  Widget _buildFeedContent(BuildContext context, WidgetRef ref) {
    final socialState = ref.watch(socialFeedProvider);
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          
          // Social Feed Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ScoutHub Feed',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(socialFeedProvider.notifier).loadPosts();
                },
                child: Text(
                  'Yenile',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Gap(16.h),
          
          // ScoutHub Feed (Shared Posts)
          if (socialState.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (socialState.posts.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(LucideIcons.share2, size: 48.sp, color: AppTheme.textGrey),
                  Gap(12.h),
                  Text(
                    'Henüz paylaşılan rapor yok',
                    style: TextStyle(color: AppTheme.textGrey, fontSize: 14.sp),
                  ),
                  Gap(8.h),
                  Text(
                    'Kendi raporlarınızı paylaşarak ScoutHub\'da görünmesini sağlayın!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textGrey.withOpacity(0.6), fontSize: 12.sp),
                  ),
                ],
              ),
            )
          else
            ...socialState.posts.map((post) {
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
            }),
          
          Gap(32.h),
          _buildCreateReportBanner(context),
          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildCreateReportBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(
            LucideIcons.plusCircle,
            size: 48.sp,
            color: AppTheme.primaryGreen,
          ),
          Gap(16.h),
          Text(
            'Oyuncu Analizine hazır mısın?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(8.h),
          Text(
            'Yeni bir rapor oluşturun ve oyuncularınızı analiz edin.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppTheme.textGrey,
            ),
          ),
          Gap(24.h),
          ElevatedButton(
            onPressed: () => context.push('/create-report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.black,
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Yeni Rapor Oluştur'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.searchX,
              size: 64.sp,
              color: AppTheme.textGrey,
            ),
            Gap(16.h),
            Text(
              'No Players Found',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            Text(
              'Try a different search term',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

