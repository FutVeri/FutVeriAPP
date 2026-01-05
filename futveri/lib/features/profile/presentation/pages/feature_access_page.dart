import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class FeatureAccessPage extends ConsumerWidget {
  const FeatureAccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isPremium = (authState.userRole?.toUpperCase() ?? 'FREE USER') != 'FREE USER' && authState.isAuthenticated;

    return Scaffold(
      appBar: AppBar(title: const Text('Feature Access')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildAccessItem(
            icon: LucideIcons.search,
            title: 'Player Search',
            status: authState.isAuthenticated ? 'Enabled' : 'Login Required',
            desc: 'Find players from all major leagues.',
            enabled: authState.isAuthenticated,
          ),
          Gap(16.h),
          _buildAccessItem(
            icon: LucideIcons.fileText,
            title: 'Scout Reporting',
            status: authState.isAuthenticated ? 'Enabled' : 'Login Required',
            desc: 'Create and export detailed analysis.',
            enabled: authState.isAuthenticated,
          ),
          Gap(16.h),
          _buildAccessItem(
            icon: LucideIcons.barChart3,
            title: 'Simulation Engine',
            status: isPremium ? 'Enabled' : 'Premium Only',
            desc: 'Simulate match scenarios and performance.',
            isPremium: true,
            enabled: isPremium,
          ),
          Gap(16.h),
          _buildAccessItem(
            icon: LucideIcons.users,
            title: 'Team Management',
            status: authState.isAuthenticated ? 'Enabled' : 'Login Required',
            desc: 'Organize your scouted talents.',
            enabled: authState.isAuthenticated,
          ),
        ],
      ),
    );
  }

  Widget _buildAccessItem({
    required IconData icon,
    required String title,
    required String status,
    required String desc,
    bool isPremium = false,
    bool enabled = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium && enabled ? Colors.amber.withOpacity(0.3) : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: isPremium ? Colors.amber : AppTheme.primaryGreen, size: 24.sp),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: (isPremium ? Colors.amber : AppTheme.primaryGreen).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: isPremium ? Colors.amber : AppTheme.primaryGreen,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(4.h),
                  Text(desc, style: const TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
