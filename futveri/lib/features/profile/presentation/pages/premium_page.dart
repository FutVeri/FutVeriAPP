import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premium Membership')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Icon(LucideIcons.crown, size: 60.sp, color: Colors.white),
                  Gap(16.h),
                  const Text('PRO SCOUT PLAN', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  Gap(8.h),
                  const Text('Active until January 15, 2026', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Gap(30.h),
            _buildFeatureTile(
              icon: LucideIcons.database,
              title: 'Unlimited Reports',
              desc: 'Create and save as many scout reports as you want.',
            ),
            Gap(16.h),
            _buildFeatureTile(
              icon: LucideIcons.trendingUp,
              title: 'Advanced Analytics',
              desc: 'Deep dive into player statistics and potential growth.',
            ),
            Gap(16.h),
            _buildFeatureTile(
              icon: LucideIcons.users,
              title: 'Collaborative Scouting',
              desc: 'Share and collaborate on reports with other scouts.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({required IconData icon, required String title, required String desc}) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.amber, size: 24.sp),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Gap(4.h),
                Text(desc, style: const TextStyle(color: AppTheme.textGrey, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
