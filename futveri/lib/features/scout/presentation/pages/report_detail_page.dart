import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:futveri/features/scout/presentation/viewmodels/scout_reports_viewmodel.dart';
import 'package:futveri/features/scout/presentation/viewmodels/create_report_viewmodel.dart';
import 'package:futveri/features/social/presentation/widgets/share_report_dialog.dart';

class ReportDetailPage extends ConsumerWidget {
  final String reportId;
  const ReportDetailPage({super.key, required this.reportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('📱 ReportDetailPage building with ID: $reportId');
    final reportAsync = ref.watch(reportByIdProvider(reportId));

    return Scaffold(
      appBar: AppBar(
        title: reportAsync.when(
          data: (report) => Text(report?.playerName.toUpperCase() ?? 'RAPOR DETAYI'),
          loading: () => const Text('YÜKLENİYOR...'),
          error: (_, __) => const Text('HATA'),
        ),
        actions: [
          reportAsync.when(
            data: (report) => report != null
                ? Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.edit3, color: AppTheme.primaryGreen),
                        onPressed: () {
                          ref.read(createReportProvider.notifier).initWithReport(report);
                          context.push('/create-report');
                        },
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.trash2, color: Colors.redAccent),
                        onPressed: () => _showDeleteConfirmation(context, ref, report.id),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.share2),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ShareReportDialog(report: report),
                          );
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: reportAsync.when(
        data: (report) {
          if (report == null) {
            print('⚠️ ReportDetailPage: No report found in data callback for ID: $reportId');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Rapor bulunamadı', style: TextStyle(color: Colors.white)),
                  Gap(16.h),
                  ElevatedButton(
                    onPressed: () => ref.refresh(reportByIdProvider(reportId)),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }
          return _buildContent(context, report);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
          print('❌ ReportDetailPage Error: $err');
          return Center(child: Text('Hata: $err', style: const TextStyle(color: Colors.white)));
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: const Text('Raporu Sil', style: TextStyle(color: Colors.white)),
        content: const Text('Bu raporu silmek istediğinize emin misiniz? Bu işlem geri alınamaz.',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              final success = await ref.read(scoutReportsProvider.notifier).deleteReport(id);
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                if (success) {
                  context.pop(); // Go back to list
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rapor silindi')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rapor silinemedi')),
                  );
                }
              }
            },
            child: const Text('Sil', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, ScoutReport scoutReport) {
    return SingleChildScrollView(
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
                Expanded(
                  child: Column(
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
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryGreen),
                  ),
                  child: Text(
                    scoutReport.overallRating.toStringAsFixed(1),
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
          
          _buildSectionHeader('Fiziksel Özellikler'),
          _buildCategoryDetails(scoutReport.physicalRating, scoutReport.physicalDescription),
          Gap(16.h),
          
          _buildSectionHeader('Teknik Özellikler'),
          _buildCategoryDetails(scoutReport.technicalRating, scoutReport.technicalDescription),
          Gap(16.h),
          
          _buildSectionHeader('Taktiksel Özellikler'),
          _buildCategoryDetails(scoutReport.tacticalRating, scoutReport.tacticalDescription),
          Gap(16.h),
          
          _buildSectionHeader('Mental Özellikler'),
          _buildCategoryDetails(scoutReport.mentalRating, scoutReport.mentalDescription),
          Gap(24.h),

          _buildAnalysisSection('Güçlü Yönler', scoutReport.strengths, AppTheme.primaryGreen),
          Gap(12.h),
          _buildAnalysisSection('Zayıf Yönler', scoutReport.weaknesses, AppTheme.errorRed),
          Gap(12.h),
          _buildAnalysisSection('Sonuç', scoutReport.recommendedRole, AppTheme.secondaryBlue),
          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: AppTheme.textGrey,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDetails(int rating, String description) {
    return Container(
      width: double.infinity,
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
                'Derecelendirme',
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
