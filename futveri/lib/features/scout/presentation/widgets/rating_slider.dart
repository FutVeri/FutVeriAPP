import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:futveri/core/theme/app_theme.dart';

class RatingSlider extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Function(int) onChanged;

  const RatingSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.max = 10,
  });

  Color _getColorForValue(int value) {
    if (value >= 8) return AppTheme.primaryGreen;
    if (value >= 5) return AppTheme.secondaryBlue;
    return AppTheme.errorRed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _getColorForValue(value).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getColorForValue(value), width: 1),
              ),
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: _getColorForValue(value),
                ),
              ),
            ),
          ],
        ),
        Gap(8.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: _getColorForValue(value),
            inactiveTrackColor: Colors.white10,
            thumbColor: Colors.white,
            overlayColor: _getColorForValue(value).withOpacity(0.2),
            valueIndicatorColor: _getColorForValue(value),
          ),
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: max.toDouble(),
            divisions: max - 1,
            label: value.toString(),
            onChanged: (val) => onChanged(val.toInt()),
          ),
        ),
      ],
    );
  }
}
