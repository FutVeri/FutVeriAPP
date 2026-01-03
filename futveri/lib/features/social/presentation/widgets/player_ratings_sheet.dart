import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';

class PlayerRatingsSheet extends StatelessWidget {
  final String playerName;
  final String playerInfo;
  final double overallRating;
  final ScoutReport? report;

  const PlayerRatingsSheet({
    super.key,
    required this.playerName,
    required this.playerInfo,
    required this.overallRating,
    this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(20.h),

            // Player Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: AppTheme.primaryGreen.withOpacity(0.2),
                    child: Icon(
                      LucideIcons.user,
                      size: 40.sp,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    playerName,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    playerInfo,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  Gap(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppTheme.primaryGreen, width: 2),
                    ),
                    child: Text(
                      'Overall: ${overallRating.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),

            // Ratings List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detailed Ratings',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(16.h),
                  _buildRatingItem(
                    'Technical',
                    report?.technicalRating?.toDouble() ?? 0.0,
                    LucideIcons.zap,
                    Colors.blue,
                  ),
                  _buildRatingItem(
                    'Physical',
                    report?.physicalRating?.toDouble() ?? 0.0,
                    LucideIcons.activity,
                    Colors.green,
                  ),
                  _buildRatingItem(
                    'Mental',
                    report?.mentalRating?.toDouble() ?? 0.0,
                    LucideIcons.brain,
                    Colors.purple,
                  ),
                  _buildRatingItem(
                    'Tactical',
                    report?.tacticalRating?.toDouble() ?? 0.0,
                    LucideIcons.target,
                    Colors.orange,
                  ),
                  _buildRatingItem(
                    'Potential',
                    report?.potentialRating?.toDouble() ?? 0.0,
                    LucideIcons.trendingUp,
                    Colors.amber,
                  ),
                  Gap(20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingItem(String label, double rating, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 20.sp, color: color),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(4.h),
                Stack(
                  children: [
                    Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: rating / 10,
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
