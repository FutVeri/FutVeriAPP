import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/scout_report.dart';
import '../../core/supabase/supabase_client.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportStatus? _selectedStatus;
  List<ScoutReport> _reports = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await supabase.client
          .from('scout_reports')
          .select()
          .order('created_at', ascending: false);
      
      final reports = (response as List).map((data) {
        // Map status from string to enum
        ReportStatus status;
        switch (data['status']) {
          case 'approved':
            status = ReportStatus.approved;
            break;
          case 'rejected':
            status = ReportStatus.rejected;
            break;
          default:
            status = ReportStatus.pending;
        }
        
        return ScoutReport(
          id: data['id'] as String,
          playerName: data['player_name'] as String,
          playerImage: data['player_image_url'] as String?,
          scoutName: 'Scout', // No scout name in current report table
          scoutId: data['scout_id'] as String,
          playerAge: data['player_age'] as int,
          position: data['player_position'] as String,
          currentClub: data['player_team'] as String,
          createdAt: DateTime.parse(data['created_at'] as String),
          status: status,
          physical: RatingDetails(
            value: data['physical_rating'] as int,
            description: data['physical_description'] as String? ?? '',
          ),
          technical: RatingDetails(
            value: data['technical_rating'] as int,
            description: data['technical_description'] as String? ?? '',
          ),
          tactical: RatingDetails(
            value: data['tactical_rating'] as int,
            description: data['tactical_description'] as String? ?? '',
          ),
          mental: RatingDetails(
            value: data['mental_rating'] as int,
            description: data['mental_description'] as String? ?? '',
          ),
          overall: RatingDetails(
            value: (data['overall_rating'] as num).round(),
            description: data['description'] as String? ?? '',
          ),
          potential: RatingDetails(
            value: (data['potential_rating'] as num).round(),
            description: data['recommended_role'] as String? ?? '',
          ),
          notes: data['notes'] as String?,
        );
      }).toList();
      
      setState(() {
        _reports = reports;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading reports: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _selectedStatus == null
        ? _reports
        : _reports.where((r) => r.status == _selectedStatus).toList();

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
                      '${_reports.length} toplam rapor',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Refresh button
                IconButton(
                  onPressed: _loadReports,
                  icon: Icon(
                    _isLoading ? LucideIcons.loader : LucideIcons.refreshCw,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const Gap(8),
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredReports.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.fileText, size: 64, color: AppTheme.textGrey),
                              const Gap(16),
                              Text(
                                'Henüz rapor yok',
                                style: TextStyle(color: AppTheme.textGrey, fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      : GlassCard(
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
    if (value >= 9) return AppTheme.primaryGreen;
    if (value >= 7) return AppTheme.secondaryBlue;
    if (value >= 5) return AppTheme.warningOrange;
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
