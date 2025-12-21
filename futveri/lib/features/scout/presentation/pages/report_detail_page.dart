import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';

class ReportDetailPage extends StatelessWidget {
  final String reportId;
  const ReportDetailPage({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final scoutReport = ScoutReport(
      id: '1',
      playerId: 'p1',
      playerName: 'Arda Güler',
      playerPosition: 'CAM',
      playerAge: 19,
      playerTeam: 'Real Madrid',
      matchDate: DateTime.now(),
      rivalTeam: 'Barcelona',
      score: '3-1',
      minutePlayed: 75,
      matchType: 'TV',
      ratings: {
          'Technique': 10,
          'Vision': 9,
          'Dribbling': 10,
          'Passing': 8,
          'Physicality': 6,
      },
      physicalAttributes: 'Agile but needs more strength.',
      technicalAttributes: 'Elite ball control and vision.',
      tacticalAttributes: 'Understands space perfectly.',
      metalAttributes: 'Confident and calm under pressure.',
      strengths: 'Dribbling, Vision, Creativity',
      weaknesses: 'Physical strength, aerial duels',
      risks: 'Injury prone due to physique',
      recommendedRole: 'Playmaker / No. 10',
      scoutId: 's1',
      createdAt: DateTime.now(),
      status: 'approved',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(scoutReport.playerName.toUpperCase()),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.share2),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Player Header Card
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.surfaceDark, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppTheme.primaryGreen,
                    child: Text(
                      scoutReport.playerPosition,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Gap(16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scoutReport.playerName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${scoutReport.playerTeam} • ${scoutReport.playerAge} yo',
                        style: TextStyle(
                          color: AppTheme.textGrey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primaryGreen),
                    ),
                    child: Text(
                      '8.8', // Overall Score
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),
            
            // Attributes Radar Chart (Placeholder) or List
            _buildAttributeList(scoutReport.ratings),

            Gap(24.h),
            _buildAnalysisSection('Strengths', scoutReport.strengths, AppTheme.primaryGreen),
            Gap(12.h),
            _buildAnalysisSection('Weaknesses', scoutReport.weaknesses, AppTheme.errorRed),
            Gap(12.h),
            _buildAnalysisSection('Conclusion', scoutReport.recommendedRole, AppTheme.secondaryBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeList(Map<String, int> ratings) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ratings.entries.map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    e.key,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: e.value / 10,
                      backgroundColor: Colors.white10,
                      color: e.value >= 8 ? AppTheme.primaryGreen : AppTheme.secondaryBlue,
                      minHeight: 8.h,
                    ),
                  ),
                ),
                Gap(12.w),
                Text(
                  e.value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAnalysisSection(String title, String content, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              letterSpacing: 1.0,
            ),
          ),
          Gap(8.h),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
