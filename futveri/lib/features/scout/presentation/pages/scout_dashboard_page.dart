import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futveri/core/theme/app_theme.dart';

class ScoutDashboardPage extends StatelessWidget {
  const ScoutDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scout Hub')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.filePlus, size: 64.sp, color: AppTheme.primaryGreen),
            Gap(20.h),
            ElevatedButton(
              onPressed: () => context.push('/create-report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.black,
              ),
              child: const Text('Create New Report'),
            ),
          ],
        ),
      ),
    );
  }
}
