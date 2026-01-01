import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/scout_report.dart';
import '../../services/mock_data_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final allReports = MockDataService().getScoutReports();
    final filteredReports = _selectedStatus == null
        ? allReports
        : allReports.where((r) => r.status == _selectedStatus).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scout Raporları',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textWhite,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      '${allReports.length} toplam rapor',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Status Filter
                ...ReportStatus.values.map((status) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _buildFilterChip(status),
                )),
                const Gap(8),
                TextButton(
                  onPressed: () => setState(() => _selectedStatus = null),
                  child: const Text(
                    'Tümü',
                    style: TextStyle(color: AppTheme.textGrey),
                  ),
                ),
              ],
            ),
            const Gap(24),
            // Reports Table
            Expanded(
              child: GlassCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ListView.separated(
                    itemCount: filteredReports.length,
                    separatorBuilder: (_, idx) => Divider(
                      color: AppTheme.glassBorder,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      return _buildReportRow(filteredReports[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(ReportStatus status) {
    final isSelected = _selectedStatus == status;
    Color color;
    String label;
    
    switch (status) {
      case ReportStatus.pending:
        color = AppTheme.warningOrange;
        label = 'Beklemede';
        break;
      case ReportStatus.approved:
        color = AppTheme.successGreen;
        label = 'Onaylı';
        break;
      case ReportStatus.rejected:
        color = AppTheme.errorRed;
        label = 'Reddedildi';
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedStatus = status),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.2) : AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? color : AppTheme.glassBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const Gap(8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : AppTheme.textGrey,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportRow(ScoutReport report) {
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showReportDetail(report),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Player Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                child: Text(
                  report.playerName.split(' ').map((n) => n[0]).join(),
                  style: const TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const Gap(16),
              // Player Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.playerName,
                      style: const TextStyle(
                        color: AppTheme.textWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${report.position} • ${report.currentClub}',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Scout
              Expanded(
                child: Text(
                  report.scoutName,
                  style: const TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 13,
                  ),
                ),
              ),
              // Overall Rating
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${report.overall.value}',
                  style: const TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Gap(16),
              // Date
              SizedBox(
                width: 100,
                child: Text(
                  _formatDate(report.createdAt),
                  style: const TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12,
                  ),
                ),
              ),
              // Status
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const Gap(16),
              const Icon(LucideIcons.chevronRight, color: AppTheme.textGrey, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inHours < 24) {
      return '${diff.inHours} saat önce';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} gün önce';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showReportDetail(ScoutReport report) {
    showDialog(
      context: context,
      builder: (context) => _ReportDetailDialog(report: report),
    );
  }
}

class _ReportDetailDialog extends StatelessWidget {
  final ScoutReport report;

  const _ReportDetailDialog({required this.report});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassmorphicContainer(
        width: 600,
        padding: const EdgeInsets.all(32),
        borderRadius: 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  child: Text(
                    report.playerName.split(' ').map((n) => n[0]).join(),
                    style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.playerName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textWhite,
                            ),
                      ),
                      Text(
                        '${report.playerAge} yaş • ${report.position} • ${report.currentClub}',
                        style: TextStyle(
                          color: AppTheme.textGrey.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x, color: AppTheme.textGrey),
                ),
              ],
            ),
            const Gap(24),
            // Ratings Grid
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildRatingCard('Fiziksel', report.physical.value, report.physical.description),
                _buildRatingCard('Teknik', report.technical.value, report.technical.description),
                _buildRatingCard('Taktik', report.tactical.value, report.tactical.description),
                _buildRatingCard('Mental', report.mental.value, report.mental.description),
                _buildRatingCard('Genel', report.overall.value, report.overall.description),
                _buildRatingCard('Potansiyel', report.potential.value, report.potential.description),
              ],
            ),
            if (report.notes != null) ...[
              const Gap(24),
              Text(
                'Notlar',
                style: const TextStyle(
                  color: AppTheme.textWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Gap(8),
              Text(
                report.notes!,
                style: TextStyle(
                  color: AppTheme.textGrey.withValues(alpha: 0.8),
                  fontSize: 13,
                ),
              ),
            ],
            const Gap(24),
            // Scout info
            Row(
              children: [
                const Icon(LucideIcons.user, color: AppTheme.textGrey, size: 16),
                const Gap(8),
                Text(
                  'Scout: ${report.scoutName}',
                  style: const TextStyle(color: AppTheme.textGrey, fontSize: 13),
                ),
                const Spacer(),
                Text(
                  report.status.displayName,
                  style: TextStyle(
                    color: _getStatusColor(report.status),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCard(String label, int value, String description) {
    return Container(
      width: 175,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.textGrey,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '$value',
                style: TextStyle(
                  color: _getRatingColor(value),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            description,
            style: TextStyle(
              color: AppTheme.textGrey.withValues(alpha: 0.7),
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(int value) {
    if (value >= 85) return AppTheme.primaryGreen;
    if (value >= 75) return AppTheme.secondaryBlue;
    if (value >= 65) return AppTheme.warningOrange;
    return AppTheme.errorRed;
  }

  Color _getStatusColor(ReportStatus status) {
    switch (status) {
      case ReportStatus.pending:
        return AppTheme.warningOrange;
      case ReportStatus.approved:
        return AppTheme.successGreen;
      case ReportStatus.rejected:
        return AppTheme.errorRed;
    }
  }
}
