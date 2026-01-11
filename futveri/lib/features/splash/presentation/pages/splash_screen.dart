import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:futveri/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _sloganController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _sloganFadeAnimation;
  late Animation<Offset> _sloganSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Slogan animation controller
    _sloganController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Slogan fade animation
    _sloganFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _sloganController, curve: Curves.easeOut),
    );

    // Slogan slide animation (from bottom)
    _sloganSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _sloganController, curve: Curves.easeOut));

    // Start animations sequence
    _startAnimations();
  }

  void _startAnimations() async {
    // Start logo animation
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();

    // Start slogan animation after logo
    await Future.delayed(const Duration(milliseconds: 500));
    _sloganController.forward();

    // Navigate to home after animations complete
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) {
      context.go('/');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              AppTheme.primaryGreen.withOpacity(0.08),
              AppTheme.backgroundBlack,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Animation
            AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoFadeAnimation.value,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    AppTheme.primaryGreen,
                    AppTheme.secondaryBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'FutVeri',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Slogan Animation
            SlideTransition(
              position: _sloganSlideAnimation,
              child: FadeTransition(
                opacity: _sloganFadeAnimation,
                child: Text(
                  'Geleceğin en büyük verisi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textGrey,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Loading indicator
            AnimatedBuilder(
              animation: _sloganController,
              builder: (context, child) {
                return Opacity(
                  opacity: _sloganFadeAnimation.value,
                  child: child,
                );
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryGreen.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
