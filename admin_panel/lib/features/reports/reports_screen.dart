import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/scout_report.dart';
import '../../services/mock_data_service.dart';
import 'report_detail_dialog.dart';

// Reports state
class ReportsState {
  final List<ScoutReport> reports;
  final String filter;

  const ReportsState({
    required this.reports,
    this.filter = 'all',
  });

  List<ScoutReport> get filteredReports {
    if (filter == 'all') return reports;
    return reports.where((r) => r.status == filter).toList();
  }

  ReportsState copyWith({List<ScoutReport>? reports, String? filter}) {
    return ReportsState(
      reports: reports ?? this.reports,
      filter: filter ?? this.filter,
    );
  }
}

// Reports notifier
class ReportsNotifier extends Notifier<ReportsState> {
  @override
  ReportsState build() {
    return ReportsState(reports: MockDataService().getScoutReports());
  }

  void setFilter(String filter) {
    state = state.copyWith(filter: filter);
  }

  void approveReport(String id) {
    final updated = state.reports.map((r) {
      if (r.id == id) return r.copyWith(status: 'approved');
      return r;
    }).toList();
    state = state.copyWith(reports: updated);
  }

  void rejectReport(String id) {
    final updated = state.reports.map((r) {
      if (r.id == id) return r.copyWith(status: 'rejected');
      return r;
    }).toList();
    state = state.copyWith(reports: updated);
  }
}

final reportsProvider = NotifierProvider<ReportsNotifier, ReportsState>(() {
  return ReportsNotifier();
});

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsState = ref.watch(reportsProvider);
    final reports = reportsState.filteredReports;

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
                      'Rapor Yönetimi',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textWhite,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      'Scout raporlarını inceleyin ve onaylayın',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(24),
            // Filter chips
            Row(
              children: [
                _buildFilterChip(
                  context,
                  ref,
                  'Tümü',
                  'all',
                  reportsState.filter,
                  reportsState.reports.length,
                ),
                const Gap(8),
                _buildFilterChip(
                  context,
                  ref,
                  'Bekleyen',
                  'submitted',
                  reportsState.filter,
                  reportsState.reports.where((r) => r.status == 'submitted').length,
                ),
                const Gap(8),
                _buildFilterChip(
                  context,
                  ref,
                  'Onaylı',
                  'approved',
                  reportsState.filter,
                  reportsState.reports.where((r) => r.status == 'approved').length,
                ),
                const Gap(8),
                _buildFilterChip(
                  context,
                  ref,
                  'Reddedildi',
                  'rejected',
                  reportsState.filter,
                  reportsState.reports.where((r) => r.status == 'rejected').length,
                ),
              ],
            ),
            const Gap(24),
            // Reports table
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(0),
                child: reports.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.inbox, color: AppTheme.textGrey, size: 48),
                            Gap(16),
                            Text(
                              'Bu kategoride rapor bulunamadı',
                              style: TextStyle(color: AppTheme.textGrey),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 24,
                          horizontalMargin: 20,
                          headingRowHeight: 56,
                          dataRowMinHeight: 64,
                          dataRowMaxHeight: 64,
                          columns: const [
                            DataColumn(label: Text('Oyuncu')),
                            DataColumn(label: Text('Pozisyon')),
                            DataColumn(label: Text('Takım')),
                            DataColumn(label: Text('Scout')),
                            DataColumn(label: Text('Tarih')),
                            DataColumn(label: Text('Puan')),
                            DataColumn(label: Text('Durum')),
                            DataColumn(label: Text('İşlemler')),
                          ],
                          rows: reports.map((report) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            AppTheme.primaryGreen.withValues(alpha: 0.2),
                                        child: Text(
                                          report.playerName[0],
                                          style: const TextStyle(
                                            color: AppTheme.primaryGreen,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            report.playerName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Yaş: ${report.playerAge}',
                                            style: const TextStyle(
                                              color: AppTheme.textGrey,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(Text(report.playerPosition)),
                                DataCell(Text(report.playerTeam)),
                                DataCell(Text(report.scoutName)),
                                DataCell(Text(_formatDate(report.createdAt))),
                                DataCell(_buildRatingBadge(report.overallRating)),
                                DataCell(_buildStatusBadge(report.status)),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(LucideIcons.eye, size: 18),
                                        color: AppTheme.textGrey,
                                        tooltip: 'Detay',
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => ReportDetailDialog(report: report),
                                          );
                                        },
                                      ),
                                      if (report.status == 'submitted') ...[
                                        IconButton(
                                          icon: const Icon(LucideIcons.check, size: 18),
                                          color: AppTheme.successGreen,
                                          tooltip: 'Onayla',
                                          onPressed: () {
                                            ref.read(reportsProvider.notifier).approveReport(report.id);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(LucideIcons.x, size: 18),
                                          color: AppTheme.errorRed,
                                          tooltip: 'Reddet',
                                          onPressed: () {
                                            ref.read(reportsProvider.notifier).rejectReport(report.id);
                                          },
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    String value,
    String currentFilter,
    int count,
  ) {
    final isSelected = value == currentFilter;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => ref.read(reportsProvider.notifier).setFilter(value),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryGreen.withValues(alpha: 0.15)
                : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppTheme.primaryGreen : AppTheme.glassBorder,
            ),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppTheme.primaryGreen : AppTheme.textWhite,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              const Gap(6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryGreen.withValues(alpha: 0.2)
                      : AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? AppTheme.primaryGreen : AppTheme.textGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    final color = rating >= 8
        ? AppTheme.successGreen
        : rating >= 6
            ? AppTheme.warningOrange
            : AppTheme.errorRed;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        rating.toStringAsFixed(1),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
