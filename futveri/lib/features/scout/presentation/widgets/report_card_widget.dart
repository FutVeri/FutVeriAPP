import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class ReportCardWidget extends StatelessWidget {
  final ScoutReport report;

  const ReportCardWidget({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/report-detail/${report.id}'),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Player Image Placeholder
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    image: report.imageUrls.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(report.imageUrls.first),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: report.imageUrls.isEmpty
                      ? Icon(LucideIcons.user, color: Colors.white24, size: 40.sp)
                      : null,
                ),
                Gap(16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              report.playerName,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildStatusBadge(report.status),
                        ],
                      ),
                      Gap(4.h),
                      Text(
                        '${report.playerTeam} • ${report.playerPosition} • ${report.playerAge}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textGrey,
                        ),
                      ),
                      Gap(8.h),
                      Row(
                        children: [
                          _buildRatingBadge(report.ratings['Technique'] ?? 0, 'TEC'),
                          Gap(8.w),
                          _buildRatingBadge(report.ratings['Pace'] ?? 0, 'PAC'),
                          if (report.ratings.containsKey('Finishing')) ...[
                              Gap(8.w),
                              _buildRatingBadge(report.ratings['Finishing']!, 'FIN'),
                          ],
                          if (report.ratings.containsKey('Vision')) ...[
                              Gap(8.w),
                              _buildRatingBadge(report.ratings['Vision']!, 'VIS'),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(16.h),
            Text(
              report.description,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white70,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(12.h),
            Divider(color: Colors.white.withOpacity(0.05)),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.calendar, size: 14.sp, color: AppTheme.textGrey),
                    Gap(4.w),
                    Text(
                      _formatDate(report.createdAt),
                      style: TextStyle(fontSize: 12.sp, color: AppTheme.textGrey),
                    ),
                  ],
                ),
                Text(
                  'Rival: ${report.rivalTeam}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.primaryGreen.withOpacity(0.8),
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

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'approved':
        color = AppTheme.primaryGreen;
        break;
      case 'submitted':
        color = AppTheme.secondaryBlue;
        break;
      default:
        color = AppTheme.textGrey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildRatingBadge(int value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(
            '$value',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
            ),
          ),
          Gap(4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
