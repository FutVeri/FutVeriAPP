import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/home/data/league_models.dart';
import 'package:futveri/features/home/data/league_mock_data.dart';

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
    final league = getMockLeague();
    final top3 = league.podium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scout Ligi',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${league.remainingDays} gün kaldı',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ],
              ),
              Text(
                'Tümünü Gör',
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
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: top3.map((member) => _buildLeaderboardItem(member)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(LeagueMember member) {
    final colors = [
      const Color(0xFFFFD700), // Gold
      const Color(0xFFC0C0C0), // Silver
      const Color(0xFFCD7F32), // Bronze
    ];
    final color = colors[member.rank - 1];
    final isLast = member.rank == 3;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 1.5),
            ),
            child: Center(
              child: Text(
                '${member.rank}',
                style: TextStyle(
                  color: color,
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
            child: Text(
              member.name.split(' ').map((n) => n[0]).join(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    ...member.badges.map((badge) => Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(badge.type.emoji, style: TextStyle(fontSize: 10.sp)),
                    )),
                  ],
                ),
                Text(
                  '${member.reportCount} Rapor',
                  style: TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${member.points}',
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
    // Get mock league data
    final league = getMockLeague();

    return Scaffold(
      appBar: AppBar(
        title: Text(league.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.info),
            onPressed: () => _showLeagueInfo(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // League header with remaining time
          _buildLeagueHeader(league),
          
          // Podium for top 3
          _buildPodium(league.podium, context),
          
          // Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Divider(color: Colors.white.withOpacity(0.1)),
          ),
          
          // Rest of the members (4-30)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: league.otherMembers.length,
              itemBuilder: (context, index) {
                return _buildMemberTile(league.otherMembers[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueHeader(League league) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.2),
            AppTheme.primaryGreen.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🏆 ${league.period}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Gap(4.h),
              Text(
                '30 Scout • Aylık Yarışma',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.clock, size: 16.sp, color: AppTheme.primaryGreen),
                Gap(6.w),
                Text(
                  '${league.remainingDays} gün kaldı',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodium(List<LeagueMember> podium, BuildContext context) {
    if (podium.length < 3) return const SizedBox.shrink();
    
    final second = podium.firstWhere((m) => m.rank == 2);
    final first = podium.firstWhere((m) => m.rank == 1);
    final third = podium.firstWhere((m) => m.rank == 3);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPodiumItem(second, const Color(0xFFC0C0C0), 80.h, context),
          _buildPodiumItem(first, const Color(0xFFFFD700), 100.h, context, isFirst: true),
          _buildPodiumItem(third, const Color(0xFFCD7F32), 60.h, context),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(LeagueMember member, Color color, double height, BuildContext context, {bool isFirst = false}) {
    return GestureDetector(
      onTap: () => _showMemberDetail(member, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with crown for first place
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: CircleAvatar(
                  radius: isFirst ? 32.r : 26.r,
                  backgroundColor: color.withOpacity(0.2),
                  child: Text(
                    member.name.split(' ').map((n) => n[0]).join(),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: isFirst ? 16.sp : 14.sp,
                    ),
                  ),
                ),
              ),
              if (isFirst)
                Positioned(
                  top: -12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text('👑', style: TextStyle(fontSize: 20.sp)),
                  ),
                ),
            ],
          ),
          Gap(8.h),
          // Name
          Text(
            member.name.split(' ')[0],
            style: TextStyle(
              fontSize: isFirst ? 14.sp : 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(2.h),
          // Points
          Text(
            '${member.points} puan',
            style: TextStyle(
              fontSize: 11.sp,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(8.h),
          // Podium base
          Container(
            width: 70.w,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.4),
                  color.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Center(
              child: Text(
                '${member.rank}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberTile(LeagueMember member, BuildContext context) {
    final isCurrentUser = member.isCurrentUser;
    
    return GestureDetector(
      onTap: () => _showMemberDetail(member, context),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isCurrentUser 
              ? AppTheme.primaryGreen.withOpacity(0.15)
              : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrentUser 
                ? AppTheme.primaryGreen.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            // Rank
            SizedBox(
              width: 32.w,
              child: Text(
                '#${member.rank}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isCurrentUser ? AppTheme.primaryGreen : AppTheme.textGrey,
                ),
              ),
            ),
            Gap(12.w),
            // Avatar
            CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: Text(
                member.name.split(' ').map((n) => n[0]).join(),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
            Gap(12.w),
            // Name and reports
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        member.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: isCurrentUser ? AppTheme.primaryGreen : Colors.white,
                        ),
                      ),
                      if (isCurrentUser) ...[
                        Gap(6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'SEN',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                      // Badges
                      ...member.badges.map((badge) => Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(badge.type.emoji, style: TextStyle(fontSize: 12.sp)),
                      )),
                    ],
                  ),
                  Text(
                    '${member.reportCount} rapor',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Points
            Text(
              '${member.points}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isCurrentUser ? AppTheme.primaryGreen : Colors.white,
              ),
            ),
            Gap(4.w),
            Text(
              'puan',
              style: TextStyle(
                fontSize: 11.sp,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMemberDetail(LeagueMember member, BuildContext context) {
    final rankColors = {
      1: const Color(0xFFFFD700),
      2: const Color(0xFFC0C0C0),
      3: const Color(0xFFCD7F32),
    };
    final rankColor = rankColors[member.rank] ?? AppTheme.primaryGreen;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Avatar
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: member.rank <= 3 ? rankColor : Colors.white24,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: (member.rank <= 3 ? rankColor : Colors.white).withOpacity(0.2),
                child: Text(
                  member.name.split(' ').map((n) => n[0]).join(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: member.rank <= 3 ? rankColor : Colors.white70,
                  ),
                ),
              ),
            ),
            Gap(16.h),
            // Name
            Text(
              member.name,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            // Rank badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: rankColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: rankColor.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (member.rank <= 3)
                    Text(
                      member.rank == 1 ? '🥇' : member.rank == 2 ? '🥈' : '🥉',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  if (member.rank <= 3) Gap(6.w),
                  Text(
                    '#${member.rank}. Sıra',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: rankColor,
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),
            // Stats grid
            Row(
              children: [
                Expanded(child: _buildStatCard('🏆', 'Puan', '${member.points}')),
                Gap(12.w),
                Expanded(child: _buildStatCard('📝', 'Rapor', '${member.reportCount}')),
                Gap(12.w),
                Expanded(child: _buildStatCard('🎯', 'Rozet', '${member.badges.length}')),
              ],
            ),
            // Badges section if has badges
            if (member.badges.isNotEmpty) ...[
              Gap(20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kazanılan Rozetler',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Gap(12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: member.badges.map((badge) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: _getBadgeColor(badge.type).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getBadgeColor(badge.type).withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(badge.type.emoji, style: TextStyle(fontSize: 16.sp)),
                      Gap(6.w),
                      Text(
                        badge.leaguePeriod,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: _getBadgeColor(badge.type),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ],
            Gap(24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String emoji, String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: 24.sp)),
          Gap(8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(LeagueBadgeType type) {
    switch (type) {
      case LeagueBadgeType.gold:
        return const Color(0xFFFFD700);
      case LeagueBadgeType.silver:
        return const Color(0xFFC0C0C0);
      case LeagueBadgeType.bronze:
        return const Color(0xFFCD7F32);
    }
  }

  void _showLeagueInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lig Sistemi Hakkında',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(16.h),
            _buildInfoRow('🏆', 'Her ligde 30 scout yarışır'),
            _buildInfoRow('📅', 'Lig süresi: 1 ay'),
            _buildInfoRow('🥇', 'Birinci: Altın rozet'),
            _buildInfoRow('🥈', 'İkinci: Gümüş rozet'),
            _buildInfoRow('🥉', 'Üçüncü: Bronz rozet'),
            _buildInfoRow('⭐', 'Rozetler profilinizde görünür'),
            Gap(24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String emoji, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 18.sp)),
          Gap(12.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

