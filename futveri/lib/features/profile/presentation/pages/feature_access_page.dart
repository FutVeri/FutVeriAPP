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
    final isPremium = (authState.userRole?.toUpperCase() ?? 'FREE') != 'FREE' && authState.isAuthenticated;

    return Scaffold(
      appBar: AppBar(title: const Text('Özellik Erişimi')),
      body: Column(
        children: [
          // Current Plan Banner
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(20.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isPremium 
                  ? Colors.amber.withOpacity(0.1)
                  : AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isPremium 
                    ? Colors.amber.withOpacity(0.3)
                    : AppTheme.primaryGreen.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isPremium ? LucideIcons.crown : LucideIcons.user,
                  color: isPremium ? Colors.amber : AppTheme.primaryGreen,
                  size: 24.sp,
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authState.isAuthenticated 
                            ? (isPremium ? 'Premium Üye' : 'Ücretsiz Kullanıcı')
                            : 'Misafir',
                        style: TextStyle(
                          color: isPremium ? Colors.amber : AppTheme.primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        isPremium 
                            ? 'Tüm özelliklere erişebilirsiniz'
                            : 'Temel özellikleri kullanabilirsiniz',
                        style: TextStyle(
                          color: AppTheme.textGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Feature List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _buildAccessItem(
                  icon: LucideIcons.search,
                  title: 'Oyuncu Arama',
                  status: authState.isAuthenticated ? 'Aktif' : 'Giriş Gerekli',
                  desc: 'Tüm büyük liglerden oyuncuları bulun.',
                  enabled: authState.isAuthenticated,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.fileText,
                  title: 'Scout Raporlama',
                  status: authState.isAuthenticated ? 'Aktif' : 'Giriş Gerekli',
                  desc: 'Detaylı analiz oluşturun ve dışa aktarın.',
                  enabled: authState.isAuthenticated,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.share2,
                  title: 'Rapor Paylaşımı',
                  status: authState.isAuthenticated ? 'Aktif' : 'Giriş Gerekli',
                  desc: 'ScoutHub\'da raporlarınızı paylaşın.',
                  enabled: authState.isAuthenticated,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.bot,
                  title: 'AI Maç Analizi',
                  status: isPremium ? 'Aktif' : 'Premium',
                  desc: 'Yapay zeka destekli rakip analizi.',
                  isPremium: true,
                  enabled: isPremium,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.barChart3,
                  title: 'Simülasyon Motoru',
                  status: isPremium ? 'Aktif' : 'Premium',
                  desc: 'Maç senaryoları ve performans simülasyonu.',
                  isPremium: true,
                  enabled: isPremium,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.users,
                  title: 'Takım Yönetimi',
                  status: authState.isAuthenticated ? 'Aktif' : 'Giriş Gerekli',
                  desc: 'Keşfettiğiniz yetenekleri organize edin.',
                  enabled: authState.isAuthenticated,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.download,
                  title: 'PDF Dışa Aktarma',
                  status: isPremium ? 'Aktif' : 'Premium',
                  desc: 'Profesyonel PDF raporları indirin.',
                  isPremium: true,
                  enabled: isPremium,
                ),
                Gap(12.h),
                _buildAccessItem(
                  icon: LucideIcons.trophy,
                  title: 'Liderlik Tablosu',
                  status: 'Aktif',
                  desc: 'Global sıralamada yerinizi görün.',
                  enabled: true,
                ),
                Gap(24.h),
              ],
            ),
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
    final statusColor = enabled 
        ? AppTheme.primaryGreen 
        : (isPremium ? Colors.amber : Colors.orange);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: enabled 
              ? (isPremium ? Colors.amber.withOpacity(0.3) : AppTheme.primaryGreen.withOpacity(0.2))
              : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: (isPremium ? Colors.amber : AppTheme.primaryGreen).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon, 
                color: enabled 
                    ? (isPremium ? Colors.amber : AppTheme.primaryGreen)
                    : AppTheme.textGrey, 
                size: 22.sp,
              ),
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title, 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 15.sp,
                          color: enabled ? Colors.white : AppTheme.textGrey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (enabled)
                              Icon(LucideIcons.check, size: 12.sp, color: statusColor),
                            if (enabled) Gap(4.w),
                            Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(4.h),
                  Text(
                    desc, 
                    style: TextStyle(
                      color: AppTheme.textGrey, 
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
