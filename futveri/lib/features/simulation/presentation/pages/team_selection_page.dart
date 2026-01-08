import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/simulation/domain/models/weekly_matches_mock.dart';
import 'package:futveri/features/simulation/domain/models/simulation_models.dart';

class TeamSelectionPage extends StatefulWidget {
  final String matchId;
  
  const TeamSelectionPage({super.key, required this.matchId});

  @override
  State<TeamSelectionPage> createState() => _TeamSelectionPageState();
}

class _TeamSelectionPageState extends State<TeamSelectionPage> {
  String? selectedTeamId;

  @override
  Widget build(BuildContext context) {
    final matches = WeeklyMatchesMock.getThisWeekMatches();
    final match = matches.firstWhere(
      (m) => m.id == widget.matchId,
      orElse: () => matches.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Takım Seç'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Header
            Text(
              'Hangi takımın teknik direktörü olmak istersin?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            Text(
              'Maça müdahale edebilir, taktik değişiklikler yapabilirsin',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppTheme.textGrey,
              ),
            ),
            Gap(32.h),
            
            // Team cards
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildTeamCard(match.homeTeam, isHome: true),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: _buildTeamCard(match.awayTeam, isHome: false),
                  ),
                ],
              ),
            ),
            
            Gap(24.h),
            
            // Start button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTeamId != null
                    ? () => context.push('/simulation/match/${widget.matchId}?team=$selectedTeamId')
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.play,
                      color: selectedTeamId != null ? Colors.black : Colors.grey,
                    ),
                    Gap(8.w),
                    Text(
                      'Maçı Başlat',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: selectedTeamId != null ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(SimulationTeam team, {required bool isHome}) {
    final isSelected = selectedTeamId == team.id;
    final teamColors = _getTeamColors(team.shortName);

    return GestureDetector(
      onTap: () => setState(() => selectedTeamId = team.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppTheme.primaryGreen.withOpacity(0.1)
              : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? AppTheme.primaryGreen
                : Colors.white.withOpacity(0.05),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Team logo
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: teamColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ] : null,
              ),
              child: Center(
                child: Text(
                  team.shortName,
                  style: TextStyle(
                    color: team.shortName == 'BJK' ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
            Gap(16.h),
            
            // Team name
            Text(
              team.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppTheme.primaryGreen : Colors.white,
              ),
            ),
            Gap(8.h),
            
            // Formation
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                team.formation,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.textGrey,
                ),
              ),
            ),
            Gap(12.h),
            
            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.star, size: 14.sp, color: const Color(0xFFFFD700)),
                Gap(4.w),
                Text(
                  team.overallRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Gap(8.h),
            
            // Home/Away indicator
            Text(
              isHome ? '🏠 Ev Sahibi' : '✈️ Deplasman',
              style: TextStyle(
                fontSize: 11.sp,
                color: AppTheme.textGrey,
              ),
            ),
            
            // Selection indicator
            if (isSelected) ...[
              Gap(12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.check, size: 14.sp, color: Colors.black),
                    Gap(4.w),
                    Text(
                      'Seçildi',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Color> _getTeamColors(String shortName) {
    final colors = {
      'GS': [const Color(0xFFFFC107), const Color(0xFFD32F2F)],
      'FB': [const Color(0xFFFFEB3B), const Color(0xFF1565C0)],
      'BJK': [Colors.white, Colors.black],
      'TS': [const Color(0xFF7B1FA2), const Color(0xFF00695C)],
    };
    return colors[shortName] ?? [Colors.grey, Colors.grey];
  }
}
