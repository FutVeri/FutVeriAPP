import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
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
                    onChanged: viewModel.updatePlayerPosition, 
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: _buildTextField(
                    label: 'Age',
                    hint: 'e.g. 23',
                    icon: LucideIcons.calendar,
                    onChanged: (val) {
                      final age = int.tryParse(val);
                      if (age != null) viewModel.updatePlayerAge(age);
                    },
                  ),
                ),
              ],
            ),
            Gap(12.h),
            _buildTextField(
              label: 'Player Team',
              hint: 'e.g. Galatasaray',
              icon: LucideIcons.shield,
              onChanged: viewModel.updatePlayerTeam,
            ),
            
            Gap(24.h),
            _buildSectionHeader('Match Context'),
            Gap(16.h),
            _buildTextField(
              label: 'Rival Team',
              hint: 'Opponent Name',
              icon: LucideIcons.swords,
              onChanged: viewModel.updateRivalTeam,
            ),
            
            Gap(24.h),
            Gap(24.h),
            _buildSectionHeader('Physical Attributes'),
            Gap(8.h),
            _buildCategorySection(
              rating: state.physicalRating,
              description: state.physicalDescription,
              onRatingChanged: viewModel.updatePhysicalRating,
              onDescriptionChanged: viewModel.updatePhysicalDescription,
            ),

            Gap(24.h),
            _buildSectionHeader('Technical Attributes'),
            Gap(8.h),
            _buildCategorySection(
              rating: state.technicalRating,
              description: state.technicalDescription,
              onRatingChanged: viewModel.updateTechnicalRating,
              onDescriptionChanged: viewModel.updateTechnicalDescription,
            ),

            Gap(24.h),
            _buildSectionHeader('Tactical Attributes'),
            Gap(8.h),
            _buildCategorySection(
              rating: state.tacticalRating,
              description: state.tacticalDescription,
              onRatingChanged: viewModel.updateTacticalRating,
              onDescriptionChanged: viewModel.updateTacticalDescription,
            ),

            Gap(24.h),
            _buildSectionHeader('Mental Attributes'),
            Gap(8.h),
            _buildCategorySection(
              rating: state.mentalRating,
              description: state.mentalDescription,
              onRatingChanged: viewModel.updateMentalRating,
              onDescriptionChanged: viewModel.updateMentalDescription,
            ),

            Gap(24.h),
            _buildSectionHeader('General Evaluation'),
            Gap(8.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  RatingSlider(
                    label: 'Overall Rating',
                    value: state.overallRating.round(),
                    max: 10,
                    onChanged: (val) => viewModel.updateOverallRating(val.toDouble()),
                  ),
                  Gap(16.h),
                  RatingSlider(
                    label: 'Potential',
                    value: state.potentialRating.round(),
                    max: 10,
                    onChanged: (val) => viewModel.updatePotentialRating(val.toDouble()),
                  ),
                ],
              ),
            ),

            Gap(24.h),
            _buildSectionHeader('Proof / Photos'),
            Gap(16.h),
            _buildImageSection(context, state, viewModel),

            Gap(24.h),
            // Error message display
            if (state.errorMessage != null)
              Container(
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(LucideIcons.alertCircle, color: Colors.red, size: 20.sp),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: state.isSubmitting
                    ? null
                    : () async {
                        print('🔘 Submit button pressed!');
                        print('🔘 isSubmitting: ${state.isSubmitting}');
                        final reportId = await viewModel.submitReport();
                        print('🔘 Report result: $reportId');
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

  Widget _buildImageSection(
    BuildContext context,
    CreateReportState state,
    CreateReportViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.imageUrls.isEmpty)
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  LucideIcons.camera,
                  size: 48.sp,
                  color: AppTheme.textGrey,
                ),
                Gap(12.h),
                Text(
                  'Photos (Optional)',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImagePickerButton(
                      context,
                      icon: LucideIcons.camera,
                      label: 'Take Photo',
                      onTap: () => _pickImage(context, viewModel, ImageSource.camera),
                    ),
                    Gap(12.w),
                    _buildImagePickerButton(
                      context,
                      icon: LucideIcons.image,
                      label: 'Gallery',
                      onTap: () => _pickImage(context, viewModel, ImageSource.gallery),
                    ),
                  ],
                ),
              ],
            ),
          )
        else
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                ),
                itemCount: state.imageUrls.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(state.imageUrls[index]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => viewModel.removeImage(index),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.x,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Gap(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImagePickerButton(
                    context,
                    icon: LucideIcons.camera,
                    label: 'Take Photo',
                    onTap: () => _pickImage(context, viewModel, ImageSource.camera),
                  ),
                  Gap(12.w),
                  _buildImagePickerButton(
                    context,
                    icon: LucideIcons.image,
                    label: 'Gallery',
                    onTap: () => _pickImage(context, viewModel, ImageSource.gallery),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildImagePickerButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20.sp, color: AppTheme.primaryGreen),
            Gap(8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(
    BuildContext context,
    CreateReportViewModel viewModel,
    ImageSource source,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    
    if (pickedFile != null) {
      viewModel.addImage(pickedFile.path);
    }
  }

  Widget _buildCategorySection({
    required int rating,
    required String description,
    required Function(int) onRatingChanged,
    required Function(String) onDescriptionChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingSlider(
            label: 'Rating',
            value: rating,
            onChanged: onRatingChanged,
          ),
          Gap(16.h),
          Text(
            'Analysis / Description',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          Gap(8.h),
          TextField(
            onChanged: onDescriptionChanged,
            maxLines: 3,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'Enter detailed analysis...',
              filled: true,
              fillColor: Colors.black.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(12.w),
            ),
          ),
        ],
      ),
    );
  }
}
