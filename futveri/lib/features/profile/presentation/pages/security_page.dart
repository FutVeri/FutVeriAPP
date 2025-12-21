import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildSecurityItem(
            icon: LucideIcons.key,
            title: 'Change Password',
            onTap: () {},
          ),
          Gap(16.h),
          _buildSecurityItem(
            icon: LucideIcons.shieldCheck,
            title: 'Two-Factor Authentication',
            onTap: () {},
          ),
          Gap(16.h),
          _buildSecurityItem(
            icon: LucideIcons.eyeOff,
            title: 'Privacy Settings',
            onTap: () {},
          ),
          Gap(16.h),
          _buildSecurityItem(
            icon: LucideIcons.trash2,
            title: 'Delete Account',
            color: AppTheme.errorRed,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppTheme.primaryGreen),
        title: Text(title, style: TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w600)),
        trailing: const Icon(LucideIcons.chevronRight, color: AppTheme.textGrey),
        onTap: onTap,
      ),
    );
  }
}
