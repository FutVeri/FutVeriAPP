import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class CommentInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final Function(String) onChanged;

  const CommentInputWidget({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // User Avatar
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AppTheme.primaryGreen.withOpacity(0.2),
              child: Icon(
                LucideIcons.user,
                size: 16.sp,
                color: AppTheme.primaryGreen,
              ),
            ),
            Gap(12.w),
            // Text Input
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  hintStyle: TextStyle(color: AppTheme.textGrey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                maxLines: null,
              ),
            ),
            Gap(12.w),
            // Send Button
            GestureDetector(
              onTap: onSend,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.send,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
