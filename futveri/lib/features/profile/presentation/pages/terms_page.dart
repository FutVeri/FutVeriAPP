import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:futveri/core/theme/app_theme.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Privacy')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Terms of Service', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Gap(12.h),
            const Text(
              'By using FutVeri, you agree to comply with our terms of service. You are responsible for the accuracy of the scouting data you provide...',
              style: TextStyle(color: AppTheme.textGrey, height: 1.5),
            ),
            Gap(30.h),
            const Text('Privacy Policy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Gap(12.h),
            const Text(
              'Your privacy is important to us. We collect data regarding your scouting activities to improve the platform and provide personalized analysis...',
              style: TextStyle(color: AppTheme.textGrey, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
