import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/features/scout/presentation/viewmodels/create_report_viewmodel.dart';
import 'package:futveri/features/scout/presentation/widgets/rating_slider.dart';
import 'package:futveri/core/theme/app_theme.dart';

class CreateReportPage extends ConsumerWidget {
  const CreateReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createReportProvider);
    final viewModel = ref.read(createReportProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Scout Report'),
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.save),
            onPressed: () {
              // Save Draft
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Player Information'),
            Gap(16.h),
            _buildTextField(
              label: 'Player Name',
              hint: 'Search or enter player name',
              icon: LucideIcons.user,
              onChanged: viewModel.updatePlayerName,
            ),
            Gap(12.h),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Position',
                    hint: 'e.g. ST',
                    icon: LucideIcons.shirt,
                    onChanged: (val) {}, 
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: _buildTextField(
                    label: 'Age',
                    hint: 'e.g. 23',
                    icon: LucideIcons.calendar,
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
            
            Gap(24.h),
            _buildSectionHeader('Match Context'),
            Gap(16.h),
            _buildTextField(
              label: 'Rival Team',
              hint: 'Opponent Name',
              icon: LucideIcons.swords,
              onChanged: (val) {},
            ),
            
            Gap(24.h),
            _buildSectionHeader('Technical Assessment'),
            Gap(8.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: state.ratings.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: RatingSlider(
                      label: entry.key,
                      value: entry.value,
                      onChanged: (val) => viewModel.updateRating(entry.key, val),
                    ),
                  );
                }).toList(),
              ),
            ),

            Gap(24.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: state.isSubmitting
                    ? null
                    : () async {
                        final reportId = await viewModel.submitReport();
                        if (context.mounted && reportId != null) {
                          context.push('/report-detail/$reportId');
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: state.isSubmitting
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Submit Report'),
              ),
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: AppTheme.textGrey,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        Gap(8.h),
        TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppTheme.textGrey),
            filled: true,
            fillColor: AppTheme.surfaceDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
            ),
          ),
        ),
      ],
    );
  }
}
