import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/scout_report.dart';
import 'reports_screen.dart';

class ReportDetailDialog extends ConsumerWidget {
  final ScoutReport report;

  const ReportDetailDialog({super.key, required this.report});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassmorphicContainer(
        width: 700,
        blur: 20,
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                    child: Text(
                      report.playerName[0],
                      style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
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
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textWhite,
                              ),
                        ),
                        const Gap(4),
                        Text(
                          '${report.playerPosition} • ${report.playerTeam} • ${report.playerAge} yaş',
                          style: const TextStyle(
                            color: AppTheme.textGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(report.status),
                  const Gap(16),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(LucideIcons.x, color: AppTheme.textGrey),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Match Info
                  _buildSection(
                    context,
                    'Maç Bilgisi',
                    LucideIcons.trophy,
                    [
                      _buildInfoRow('Maç', '${report.playerTeam} vs ${report.rivalTeam}'),
                      _buildInfoRow('Skor', report.score),
                      _buildInfoRow('Oynanan', '${report.minutePlayed} dakika'),
                      _buildInfoRow('Tip', report.matchType),
                      _buildInfoRow('Tarih', _formatDate(report.matchDate)),
                    ],
                  ),
                  const Gap(20),
                  // Ratings
                  _buildSection(
                    context,
                    'Puanlar',
                    LucideIcons.star,
                    [],
                  ),
                  const Gap(8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildRatingChip('Fiziksel', report.physicalRating),
                      _buildRatingChip('Teknik', report.technicalRating),
                      _buildRatingChip('Taktik', report.tacticalRating),
                      _buildRatingChip('Mental', report.mentalRating),
                      _buildRatingChip('Genel', report.overallRating.toInt()),
                      _buildRatingChip('Potansiyel', report.potentialRating.toInt()),
                    ],
                  ),
                  const Gap(20),
                  // Analysis
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSection(
                              context,
                              'Analiz',
                              LucideIcons.clipboardList,
                              [
                                _buildAnalysisItem('Fiziksel', report.physicalDescription),
                                _buildAnalysisItem('Teknik', report.technicalDescription),
                                _buildAnalysisItem('Taktik', report.tacticalDescription),
                                _buildAnalysisItem('Mental', report.mentalDescription),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSection(
                              context,
                              'SWOT',
                              LucideIcons.target,
                              [
                                _buildSwotItem('Güçlü Yönler', report.strengths, AppTheme.successGreen),
                                _buildSwotItem('Zayıf Yönler', report.weaknesses, AppTheme.warningOrange),
                                _buildSwotItem('Riskler', report.risks, AppTheme.errorRed),
                                _buildSwotItem('Önerilen Rol', report.recommendedRole, AppTheme.secondaryBlue),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  // Scout Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.user, color: AppTheme.textGrey, size: 18),
                        const Gap(8),
                        Text(
                          'Scout: ${report.scoutName}',
                          style: const TextStyle(color: AppTheme.textGrey, fontSize: 13),
                        ),
                        const Spacer(),
                        Text(
                          'Oluşturulma: ${_formatDate(report.createdAt)}',
                          style: const TextStyle(color: AppTheme.textGrey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Actions
            if (report.status == 'submitted')
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppTheme.glassBorder),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        ref.read(reportsProvider.notifier).rejectReport(report.id);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(LucideIcons.x, size: 18),
                      label: const Text('Reddet'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.errorRed,
                        side: const BorderSide(color: AppTheme.errorRed),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                    const Gap(12),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.read(reportsProvider.notifier).approveReport(report.id);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(LucideIcons.check, size: 18),
                      label: const Text('Onayla'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successGreen,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 18),
            const Gap(8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textWhite,
                  ),
            ),
          ],
        ),
        if (children.isNotEmpty) ...[
          const Gap(12),
          ...children,
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: AppTheme.textGrey, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: AppTheme.textWhite, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChip(String label, int value) {
    final color = value >= 8
        ? AppTheme.successGreen
        : value >= 6
            ? AppTheme.warningOrange
            : AppTheme.errorRed;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppTheme.textWhite, fontSize: 12),
          ),
          const Gap(8),
          Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textGrey,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(2),
          Text(
            value,
            style: const TextStyle(color: AppTheme.textWhite, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSwotItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(2),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              value,
              style: const TextStyle(color: AppTheme.textWhite, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
