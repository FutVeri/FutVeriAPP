import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FutVeri Scout')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to FutVeri'),
            Gap(20.h),
            ElevatedButton(
              onPressed: () => context.push('/create-report'),
              child: const Text('Create Scout Report'),
            ),
          ],
        ),
      ),
    );
  }
}
