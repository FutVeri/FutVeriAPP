import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/simulation/domain/models/weekly_matches_mock.dart';
import 'package:futveri/features/simulation/domain/models/match_simulation_models.dart';

class SimulationPage extends StatelessWidget {
  const SimulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = WeeklyMatchesMock.getThisWeekMatches();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maç Simülasyonu'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            Gap(24.h),
            
            // Week selector
            _buildWeekSelector(),
            Gap(20.h),
            
            // Matches list
            Text(
              "Bu Hafta'nın Maçları",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(12.h),
            
            ...matches.map((match) => _buildMatchCard(context, match)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1).withOpacity(0.3),
            const Color(0xFF8B5CF6).withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.gamepad2, color: const Color(0xFF6366F1), size: 28.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FutVeri Simülasyon',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Gap(4.h),
                Text(
                  'Teknik direktör olarak maça müdahale et',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(LucideIcons.chevronLeft, color: AppTheme.textGrey),
          Column(
            children: [
              Text(
                '18. Hafta',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Süper Lig 2025-26',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
          Icon(LucideIcons.chevronRight, color: AppTheme.textGrey),
        ],
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, WeeklyMatch match) {
    return GestureDetector(
      onTap: () => context.push('/simulation/team-select/${match.id}'),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            // Date and stadium
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(match.matchDateTime),
                  style: TextStyle(color: AppTheme.textGrey, fontSize: 11.sp),
                ),
                Text(
                  match.stadium,
                  style: TextStyle(color: AppTheme.textGrey, fontSize: 11.sp),
                ),
              ],
            ),
            Gap(12.h),
            // Teams
            Row(
              children: [
                // Home team
                Expanded(
                  child: Row(
                    children: [
                      _buildTeamLogo(match.homeTeam.shortName),
                      Gap(10.w),
                      Expanded(
                        child: Text(
                          match.homeTeam.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // VS
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _formatTime(match.matchDateTime),
                    style: TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                // Away team
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          match.awayTeam.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Gap(10.w),
                      _buildTeamLogo(match.awayTeam.shortName),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),
            // Play button hint
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.play, size: 14.sp, color: AppTheme.primaryGreen),
                Gap(6.w),
                Text(
                  'Simüle Et',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogo(String shortName) {
    final colors = {
      'GS': [const Color(0xFFFFC107), const Color(0xFFD32F2F)],
      'FB': [const Color(0xFFFFEB3B), const Color(0xFF1565C0)],
      'BJK': [Colors.white, Colors.black],
      'TS': [const Color(0xFF7B1FA2), const Color(0xFF00695C)],
    };
    
    final teamColors = colors[shortName] ?? [Colors.grey, Colors.grey];
    
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: teamColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          shortName,
          style: TextStyle(
            color: shortName == 'BJK' ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
    const months = ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];
    return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month - 1]}';
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
