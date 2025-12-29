import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/glassmorphism.dart';
import '../../../models/scout_report.dart';

class RecentReportsWidget extends StatelessWidget {
  final List<ScoutReport> reports;

  const RecentReportsWidget({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.fileText, color: AppTheme.warningOrange, size: 18),
              const SizedBox(width: 8),
              Text(
                'Son Raporlar',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textWhite,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.go('/reports'),
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
          const SizedBox(height: 12),
          ...reports.map((report) => _buildReportItem(report)),
        ],
      ),
    );
  }

  Widget _buildReportItem(ScoutReport report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
            child: Text(
              report.playerName[0],
              style: const TextStyle(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
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
                  '${report.playerPosition} • ${report.playerTeam}',
                  style: const TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(report.status),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = switch (status) {
      'submitted' => AppTheme.warningOrange,
      'approved' => AppTheme.successGreen,
      'rejected' => AppTheme.errorRed,
      _ => AppTheme.textGrey,
    };
    final label = switch (status) {
      'submitted' => 'Bekliyor',
      'approved' => 'Onaylı',
      'rejected' => 'Reddedildi',
      _ => status,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
