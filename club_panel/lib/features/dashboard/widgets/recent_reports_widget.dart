import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/glassmorphism.dart';
import '../../../models/scout_report.dart';

class RecentReportsWidget extends StatelessWidget {
  final List<ScoutReport> reports;

  const RecentReportsWidget({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.fileText,
                  color: AppTheme.primaryGreen, size: 18),
              const Gap(8),
              Text(
                'Son Raporlar',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textWhite,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Tümünü Gör',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          ...reports.map((report) => _buildReportItem(report)),
        ],
      ),
    );
  }

  Widget _buildReportItem(ScoutReport report) {
    Color statusColor;
    switch (report.status) {
      case ReportStatus.pending:
        statusColor = AppTheme.warningOrange;
        break;
      case ReportStatus.approved:
        statusColor = AppTheme.successGreen;
        break;
      case ReportStatus.rejected:
        statusColor = AppTheme.errorRed;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.surfaceLight,
            child: Text(
              report.playerName[0],
              style: const TextStyle(
                color: AppTheme.textWhite,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.playerName,
                  style: const TextStyle(
                    color: AppTheme.textWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '${report.position} • ${report.scoutName}',
                  style: TextStyle(
                    color: AppTheme.textGrey.withValues(alpha: 0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
