import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class FeedFilterSheet extends StatefulWidget {
  const FeedFilterSheet({super.key});

  @override
  State<FeedFilterSheet> createState() => _FeedFilterSheetState();
}

class _FeedFilterSheetState extends State<FeedFilterSheet> {
  RangeValues _ageRange = const RangeValues(18, 30);
  RangeValues _marketValueRange = const RangeValues(0, 100);
  double _minRating = 0;
  String _selectedPosition = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(20.h),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(LucideIcons.filter, size: 24.sp, color: AppTheme.primaryGreen),
                  Gap(12.w),
                  Text(
                    'Filter Posts',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _ageRange = const RangeValues(18, 30);
                        _marketValueRange = const RangeValues(0, 100);
                        _minRating = 0;
                        _selectedPosition = 'All';
                      });
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: AppTheme.textGrey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),

            // Filters Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Age Range
                    _buildSectionTitle('Player Age'),
                    Gap(12.h),
                    _buildRangeSlider(
                      'Age',
                      _ageRange,
                      0,
                      40,
                      (values) => setState(() => _ageRange = values),
                      suffix: ' years',
                    ),
                    Gap(24.h),

                    // Market Value Range
                    _buildSectionTitle('Market Value'),
                    Gap(12.h),
                    _buildRangeSlider(
                      'Market Value',
                      _marketValueRange,
                      0,
                      150,
                      (values) => setState(() => _marketValueRange = values),
                      suffix: 'M €',
                    ),
                    Gap(24.h),

                    // Minimum Rating
                    _buildSectionTitle('Minimum Rating'),
                    Gap(12.h),
                    _buildSingleSlider(
                      'Rating',
                      _minRating,
                      0,
                      10,
                      (value) => setState(() => _minRating = value),
                    ),
                    Gap(24.h),

                    // Position Filter
                    _buildSectionTitle('Position'),
                    Gap(12.h),
                    _buildPositionChips(),
                    Gap(32.h),
                  ],
                ),
              ),
            ),

            // Apply Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters
                    Navigator.pop(context, {
                      'ageRange': _ageRange,
                      'marketValueRange': _marketValueRange,
                      'minRating': _minRating,
                      'position': _selectedPosition,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRangeSlider(
    String label,
    RangeValues values,
    double min,
    double max,
    Function(RangeValues) onChanged, {
    String suffix = '',
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
              ),
              child: Text(
                '${values.start.round()}$suffix',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
            Icon(LucideIcons.arrowRight, size: 16.sp, color: AppTheme.textGrey),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
              ),
              child: Text(
                '${values.end.round()}$suffix',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: AppTheme.primaryGreen,
          inactiveColor: AppTheme.surfaceDark,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSingleSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum: ${value.toStringAsFixed(1)} ⭐',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textGrey,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppTheme.primaryGreen),
              ),
              child: Text(
                value.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 20,
          activeColor: AppTheme.primaryGreen,
          inactiveColor: AppTheme.surfaceDark,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPositionChips() {
    final positions = ['All', 'GK', 'DEF', 'MID', 'FW'];
    
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: positions.map((position) {
        final isSelected = _selectedPosition == position;
        return GestureDetector(
          onTap: () => setState(() => _selectedPosition = position),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primaryGreen.withOpacity(0.2)
                  : AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppTheme.primaryGreen : Colors.white10,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              position,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppTheme.primaryGreen : Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
