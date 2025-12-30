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
      physicalRating: 6,
      physicalDescription: 'Agile but needs more strength.',
      technicalRating: 10,
      technicalDescription: 'Elite ball control and vision.',
      tacticalRating: 9,
      tacticalDescription: 'Understands space perfectly.',
      mentalRating: 9,
      mentalDescription: 'Confident and calm under pressure.',
      overallRating: 8.8,
      potentialRating: 9.5,
      strengths: 'Dribbling, Vision, Creativity',
      weaknesses: 'Physical strength, aerial duels',
      risks: 'Injury prone due to physique',
      recommendedRole: 'Playmaker / No. 10',
      scoutId: 's1',
      createdAt: DateTime.now(),
      description: 'Exceptional performance in El Clásico. Showed maturity beyond his years.',
      imageUrls: [],
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
                      scoutReport.overallRating.toString(), // Overall Score
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
            _buildSectionHeader('Physical Attributes'),
            _buildCategoryDetails(scoutReport.physicalRating, scoutReport.physicalDescription),
            Gap(16.h),
            
            _buildSectionHeader('Technical Attributes'),
            _buildCategoryDetails(scoutReport.technicalRating, scoutReport.technicalDescription),
            Gap(16.h),
            
            _buildSectionHeader('Tactical Attributes'),
            _buildCategoryDetails(scoutReport.tacticalRating, scoutReport.tacticalDescription),
            Gap(16.h),
            
            _buildSectionHeader('Mental Attributes'),
            _buildCategoryDetails(scoutReport.mentalRating, scoutReport.mentalDescription),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppTheme.textGrey,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCategoryDetails(int rating, String description) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rating',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getRatingColor(rating).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getRatingColor(rating)),
                ),
                child: Text(
                  '$rating/10',
                  style: TextStyle(
                    color: _getRatingColor(rating),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 8) return AppTheme.primaryGreen;
    if (rating >= 5) return AppTheme.secondaryBlue;
    return AppTheme.errorRed;
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
