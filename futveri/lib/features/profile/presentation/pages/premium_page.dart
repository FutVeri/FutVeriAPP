import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class PremiumPage extends ConsumerWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userRole = authState.userRole?.toUpperCase() ?? 'FREE USER';
    final isPremium = userRole != 'FREE USER' && authState.isAuthenticated;

    return Scaffold(
      appBar: AppBar(title: const Text('Premium Membership')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPremium ? [Colors.amber, Colors.orange] : [AppTheme.surfaceDark, AppTheme.textGrey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Icon(LucideIcons.crown, size: 60.sp, color: Colors.white),
                  Gap(16.h),
                  Text(
                    authState.isAuthenticated ? '$userRole PLAN' : 'GIRIŞ YAPILMADI',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Gap(8.h),
                  if (authState.isAuthenticated)
                    const Text('Active Subscription', style: TextStyle(color: Colors.white70))
                  else
                    const Text('Oturum açarak planınızı görün', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Gap(30.h),
            _buildFeatureTile(
              icon: LucideIcons.database,
              title: 'Unlimited Reports',
              desc: 'Create and save as many scout reports as you want.',
              active: isPremium,
            ),
            Gap(16.h),
            _buildFeatureTile(
              icon: LucideIcons.trendingUp,
              title: 'Advanced Analytics',
              desc: 'Deep dive into player statistics and potential growth.',
              active: isPremium,
            ),
            Gap(16.h),
            _buildFeatureTile(
              icon: LucideIcons.users,
              title: 'Collaborative Scouting',
              desc: 'Share and collaborate on reports with other scouts.',
              active: isPremium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String desc,
    bool active = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: active ? Colors.amber.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: active ? Colors.amber : AppTheme.textGrey, size: 24.sp),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: active ? Colors.white : AppTheme.textGrey,
                  ),
                ),
                Gap(4.h),
                Text(
                  desc,
                  style: TextStyle(
                    color: active ? AppTheme.textGrey : AppTheme.textGrey.withOpacity(0.5),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
