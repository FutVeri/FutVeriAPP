import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/scout/presentation/viewmodels/scout_reports_viewmodel.dart';
import 'package:futveri/features/scout/presentation/widgets/report_card_widget.dart';

class ScoutDashboardPage extends ConsumerWidget {
  const ScoutDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoutReportsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scout Hub'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search),
            onPressed: () {
              // Search reports
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.plusCircle),
            onPressed: () => context.push('/create-report'),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.reports.isEmpty
              ? _buildEmptyState(context)
              : _buildReportsList(state),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create-report'),
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(LucideIcons.filePlus, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.fileSearch2,
                size: 64.sp,
                color: AppTheme.primaryGreen,
              ),
            ),
            Gap(24.h),
            Text(
              'No Reports Found',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(12.h),
            Text(
              'You haven\'t created any scout reports yet. Start by analyzing a player and creating your first report.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textGrey,
                height: 1.5,
              ),
            ),
            Gap(32.h),
            SSurfaceButton(
              onPressed: () => context.push('/create-report'),
              child: const Text('Create Your First Report'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsList(ScoutReportsState state) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: state.reports.length,
      itemBuilder: (context, index) {
        final report = state.reports[index];
        return ReportCardWidget(report: report);
      },
    );
  }
}

class SSurfaceButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const SSurfaceButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: child,
    );
  }
}
