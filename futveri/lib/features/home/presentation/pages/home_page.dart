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

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutVeri Scout'),
        actions: [
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
              hintText: 'Search players by name, position, or team...',
              onChanged: viewModel.updateSearchQuery,
              onClear: viewModel.clearSearch,
            ),
          ),
          
          // Results or Dashboard
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildBody(context, state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state.searchQuery.isEmpty) {
      return _buildDashboardContent(context);
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

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          _buildNavigationCard(
            context: context,
            title: 'AI Rival Analysis',
            subtitle: 'Get instant AI insights for upcoming matches',
            icon: LucideIcons.bot,
            gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            onTap: () => context.push('/ai-analysis'),
          ),
          Gap(24.h),
          _buildNavigationCard(
            context: context,
            title: 'Top Rated Reports',
            subtitle: 'Explore the highest quality scout analysis',
            icon: LucideIcons.trendingUp,
            gradient: const [Color(0xFF10B981), Color(0xFF059669)],
            onTap: () => context.push('/popular-feed'),
          ),
          Gap(24.h),
          _buildNavigationCard(
            context: context,
            title: 'Global Leaderboard',
            subtitle: 'Compete with the best scouts worldwide',
            icon: LucideIcons.award,
            gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
            onTap: () => context.push('/leaderboard'),
          ),
          Gap(32.h),
          
          // Social Feed Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Reports',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Gap(16.h),
          
          // Social Feed Posts
          const FeedPostWidget(
            scoutName: 'Ahmet Yılmaz',
            playerName: 'Semih Kılıçsoy',
            playerInfo: 'Beşiktaş • FW • 19 yo',
            rating: 8.5,
            comment: 'Incredible finishing ability for his age. Needs to improve decision making in tight spaces.',
            likes: 124,
          ),
          const FeedPostWidget(
            scoutName: 'Global Scout',
            playerName: 'Can Uzun',
            playerInfo: 'FC Nürnberg • CAM • 18 yo',
            rating: 9.0,
            comment: 'Top class vision. A true number 10 potential.',
            likes: 350,
          ),
          const FeedPostWidget(
            scoutName: 'FutVeri Analytics',
            playerName: 'Enis Destan',
            playerInfo: 'Trabzonspor • ST • 21 yo',
            rating: 7.8,
            comment: 'Strong aerial ability. Holding play is developing well.',
            likes: 89,
          ),
          
          Gap(32.h),
          _buildCreateReportBanner(context),
          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildNavigationCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 28.sp),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, color: Colors.white.withOpacity(0.7)),
          ],
        ),
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
            'Ready to Scout?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(8.h),
          Text(
            'Create a new report for a player you\'ve watched recently.',
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
            child: const Text('Create New Report'),
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
