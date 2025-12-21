import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/profile/presentation/widgets/profile_list_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            _buildProfileHeader(),
            Gap(32.h),
            _buildSection(
              title: 'Account',
              items: [
                ProfileListItem(
                  icon: LucideIcons.user,
                  title: 'Personal Information',
                  subtitle: 'Update your profile details',
                  onTap: () => context.push('/profile/info'),
                ),
                ProfileListItem(
                  icon: LucideIcons.bell,
                  title: 'Notifications',
                  subtitle: 'Manage your alerts',
                  onTap: () => context.push('/profile/notifications'),
                ),
                ProfileListItem(
                  icon: LucideIcons.lock,
                  title: 'Privacy & Security',
                  onTap: () => context.push('/profile/security'),
                ),
              ],
            ),
            Gap(24.h),
            _buildSection(
              title: 'Membership',
              items: [
                ProfileListItem(
                  icon: LucideIcons.award,
                  title: 'Premium Subscription',
                  subtitle: 'Active until Jan 2026',
                  iconColor: Colors.amber,
                  onTap: () => context.push('/profile/premium'),
                ),
                ProfileListItem(
                  icon: LucideIcons.zap,
                  title: 'Feature Access',
                  onTap: () => context.push('/profile/features'),
                ),
              ],
            ),
            Gap(24.h),
            _buildSection(
              title: 'Authentication',
              items: [
                ProfileListItem(
                  icon: LucideIcons.logIn,
                  title: 'Sign In / Register',
                  onTap: () => context.push('/login'),
                ),
                ProfileListItem(
                  icon: LucideIcons.logOut,
                  title: 'Logout',
                  iconColor: AppTheme.errorRed,
                  onTap: () {
                    // Mock logout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  },
                ),
              ],
            ),
            Gap(24.h),
            _buildSection(
              title: 'Application',
              items: [
                ProfileListItem(
                  icon: LucideIcons.bookOpen,
                  title: 'Licenses',
                  onTap: () => _showLicensePage(context),
                ),
                ProfileListItem(
                  icon: LucideIcons.shieldCheck,
                  title: 'Terms of Service',
                  onTap: () => context.push('/profile/terms'),
                ),
                ProfileListItem(
                  icon: LucideIcons.info,
                  title: 'Version',
                  trailing: Text(
                    '1.0.0',
                    style: TextStyle(
                      color: AppTheme.textGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryGreen, width: 2),
              ),
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: AppTheme.surfaceDark,
                child: Icon(LucideIcons.user, size: 50.sp, color: AppTheme.textGrey),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.camera, size: 16.sp, color: Colors.black),
              ),
            ),
          ],
        ),
        Gap(16.h),
        Text(
          'Emre Mert',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Gap(4.h),
        Text(
          'emre@futveri.com',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppTheme.textGrey,
          ),
        ),
        Gap(12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
          ),
          child: Text(
            'PRO SCOUT',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textGrey,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Gap(12.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  void _showLicensePage(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'FutVeri App',
      applicationVersion: '1.0.0',
      applicationIcon: Padding(
        padding: EdgeInsets.all(20.w),
        child: Icon(LucideIcons.shield, size: 48.sp, color: AppTheme.primaryGreen),
      ),
    );
  }
}
