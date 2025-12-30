import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class AiAnalysisCard extends StatelessWidget {
  final VoidCallback onTap;

  const AiAnalysisCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)], // Indigo to Purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.3),
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
              child: Icon(LucideIcons.bot, color: Colors.white, size: 28.sp),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Rival Analysis',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Get instant AI insights for upcoming matches',
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
}

class PopularFeedSection extends StatelessWidget {
  const PopularFeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated / Trends',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Gap(12.h),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => Gap(12.w),
            itemBuilder: (context, index) {
              return _buildPopularCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularCard(int index) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white10,
                child: Text('P${index + 1}', style: TextStyle(fontSize: 10.sp)),
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  'Arda G.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(LucideIcons.barChart2, color: AppTheme.primaryGreen),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9.2 Rating',
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(LucideIcons.heart, size: 12.sp, color: Colors.redAccent),
                  Gap(4.w),
                  Text(
                    '${120 + index * 10}',
                    style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Scout Leaderboard',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Gap(12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: List.generate(3, (index) => _buildLeaderboardItem(index)),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(int index) {
    final colors = [
      const Color(0xFFFFD700), // Gold
      const Color(0xFFC0C0C0), // Silver
      const Color(0xFFCD7F32), // Bronze
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: index != 2 ? 16.h : 0),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: colors[index].withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: colors[index], width: 1.5),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: colors[index],
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Gap(12.w),
          CircleAvatar(
            radius: 18.r,
            backgroundColor: Colors.white10,
            child: Icon(LucideIcons.user, size: 18.sp, color: Colors.white70),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ScoutUser_${99 - index}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${45 - index * 5} Reports',
                  style: TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${1250 - index * 100} pts',
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// --- NEW PAGES ---

class AiAnalysisPage extends StatelessWidget {
  const AiAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Analysis')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.bot, size: 80, color: AppTheme.primaryGreen),
            Gap(20.h),
            const Text('AI Rival Analysis Engine', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            Gap(10.h),
            const Text('Processing match data and rival tactics...', style: TextStyle(color: AppTheme.textGrey)),
            Gap(40.h),
            const CircularProgressIndicator(color: AppTheme.primaryGreen),
          ],
        ),
      ),
    );
  }
}

class PopularFeedPage extends StatelessWidget {
  const PopularFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trending Reports')),
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: AppTheme.primaryGreen.withOpacity(0.2), child: Text('${index + 1}')),
                Gap(16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Arda G. - Real Madrid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                      Text('Scouted by Expert_Scout_${index}', style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp)),
                    ],
                  ),
                ),
                Text('9.${index} ⭐', style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Global Leaderboard')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            color: AppTheme.surfaceDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPodiumItem('User 2', 'Silver', Colors.grey),
                _buildPodiumItem('User 1', 'Gold', const Color(0xFFFFD700), isCenter: true),
                _buildPodiumItem('User 3', 'Bronze', const Color(0xFFCD7F32)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('#${index + 4}', style: const TextStyle(color: AppTheme.textGrey)),
                  title: Text('Scout_User_${index + 4}', style: const TextStyle(color: Colors.white)),
                  subtitle: Text('${1000 - index * 20} points', style: const TextStyle(color: AppTheme.textGrey)),
                  trailing: const Icon(LucideIcons.chevronRight, color: Colors.white24),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(String name, String rank, Color color, {bool isCenter = false}) {
    return Column(
      children: [
        Icon(LucideIcons.trophy, color: color, size: isCenter ? 48.sp : 32.sp),
        Gap(8.h),
        Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isCenter ? 16.sp : 14.sp)),
        Text(rank, style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp)),
      ],
    );
  }
}
