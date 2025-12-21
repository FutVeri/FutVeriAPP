import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final viewModel = ref.read(authProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // Background UI
          _buildBackground(),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  Gap(60.h),
                  _buildHeader(state.isLoginMode),
                  Gap(40.h),
                  _buildGlassForm(state, viewModel),
                  Gap(30.h),
                  _buildToggleMode(state, viewModel),
                  Gap(40.h),
                ],
              ),
            ),
          ),
          
          // Close button
          Positioned(
            top: 50.h,
            left: 20.w,
            child: IconButton(
              icon: const Icon(LucideIcons.x, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundBlack,
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1574629810360-7efbbe195018?q=80&w=2000'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppTheme.backgroundBlack.withOpacity(0.8),
              AppTheme.backgroundBlack,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoginMode) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
          ),
          child: Icon(
            LucideIcons.shield,
            size: 60.sp,
            color: AppTheme.primaryGreen,
          ),
        ),
        Gap(24.h),
        Text(
          isLoginMode ? 'Welcome Back' : 'Join FutVeri',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        Gap(8.h),
        Text(
          isLoginMode 
              ? 'Enter your credentials to continue' 
              : 'Create a scout account to start',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppTheme.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassForm(AuthState state, AuthViewModel viewModel) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              if (!state.isLoginMode) ...[
                _buildField(
                  controller: _nameController,
                  hint: 'Full Name',
                  icon: LucideIcons.user,
                ),
                Gap(20.h),
              ],
              _buildField(
                controller: _emailController,
                hint: 'Email Address',
                icon: LucideIcons.mail,
                keyboardType: TextInputType.emailAddress,
              ),
              Gap(20.h),
              _buildField(
                controller: _passwordController,
                hint: 'Password',
                icon: LucideIcons.lock,
                isPassword: true,
              ),
              if (state.error != null) ...[
                Gap(16.h),
                Text(
                  state.error!,
                  style: const TextStyle(color: AppTheme.errorRed, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
              Gap(30.h),
              _buildSubmitButton(state, viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppTheme.textGrey, size: 20),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppTheme.primaryGreen),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18.h),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(AuthState state, AuthViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: state.isLoading 
            ? null 
            : () async {
                bool success;
                if (state.isLoginMode) {
                  success = await viewModel.login(
                    _emailController.text, 
                    _passwordController.text
                  );
                } else {
                  success = await viewModel.register(
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text
                  );
                }
                
                if (success && mounted) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.isLoginMode ? 'Welcome back!' : 'Account created!'),
                      backgroundColor: AppTheme.primaryGreen,
                    ),
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: state.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
              )
            : Text(
                state.isLoginMode ? 'Login' : 'Create Account',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildToggleMode(AuthState state, AuthViewModel viewModel) {
    return TextButton(
      onPressed: viewModel.toggleMode,
      child: RichText(
        text: TextSpan(
          text: state.isLoginMode ? "Don't have an account? " : "Already have an account? ",
          style: TextStyle(color: AppTheme.textGrey, fontSize: 15.sp),
          children: [
            TextSpan(
              text: state.isLoginMode ? 'Sign Up' : 'Login',
              style: const TextStyle(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
