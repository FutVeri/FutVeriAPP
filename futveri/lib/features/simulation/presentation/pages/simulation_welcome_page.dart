import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class SimulationWelcomePage extends StatefulWidget {
  const SimulationWelcomePage({super.key});

  @override
  State<SimulationWelcomePage> createState() => _SimulationWelcomePageState();
}

class _SimulationWelcomePageState extends State<SimulationWelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showMenu = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeIn)),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack)),
    );

    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _showMenu = true);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100.h,
            right: -100.w,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryGreen.withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_showMenu)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(24.w),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGreen.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.2)),
                              ),
                              child: Icon(LucideIcons.gamepad2, size: 64.sp, color: AppTheme.primaryGreen),
                            ),
                            Gap(32.h),
                            Text(
                              'Simülasyona Hoş Geldin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Gap(12.h),
                            Text(
                              'Geleceğin en büyük verisi senin ellerinde.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppTheme.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  if (_showMenu)
                    AnimatedOpacity(
                      opacity: _showMenu ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Simülasyon Modu Seç',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Gap(40.h),
                          _buildMenuButton(
                            icon: LucideIcons.calendarDays,
                            title: 'Haftalık Oyna',
                            subtitle: 'Güncel fikstürdeki maçları yönet.',
                            color: AppTheme.primaryGreen,
                            onTap: () => context.push('/simulation/weekly'),
                          ),
                          Gap(16.h),
                          _buildMenuButton(
                            icon: LucideIcons.trophy,
                            title: 'Kariyer Devam Et',
                            subtitle: 'Kendi takımını şampiyonluğa taşı.',
                            color: Colors.orange,
                            enabled: false,
                          ),
                          Gap(16.h),
                          _buildMenuButton(
                            icon: LucideIcons.playCircle,
                            title: 'Oyna Devam Et',
                            subtitle: 'Kaldığın yerden hemen başla.',
                            color: Colors.blue,
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: enabled ? color.withOpacity(0.3) : Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: [
              if (enabled)
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24.sp),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      enabled ? subtitle : 'Çok yakında...',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              if (enabled)
                Icon(LucideIcons.chevronRight, color: AppTheme.textGrey, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
