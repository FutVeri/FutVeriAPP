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
    final userRole = authState.userRole?.toUpperCase() ?? 'FREE';
    final isPremium = userRole != 'FREE' && authState.isAuthenticated;

    return Scaffold(
      appBar: AppBar(title: const Text('Bireysel Abonelik')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Current Plan Card
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPremium 
                      ? [Colors.amber, Colors.orange] 
                      : [AppTheme.surfaceDark, const Color(0xFF2A2A2A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: isPremium ? null : Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Icon(
                    isPremium ? LucideIcons.crown : LucideIcons.user, 
                    size: 60.sp, 
                    color: Colors.white,
                  ),
                  Gap(16.h),
                  Text(
                    authState.isAuthenticated 
                        ? (isPremium ? 'PREMİUM ÜYE' : 'ÜCRETSİZ KULLANICI')
                        : 'GİRİŞ YAPILMADI',
                    style: TextStyle(
                      fontSize: 22.sp, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    authState.isAuthenticated 
                        ? (isPremium ? 'Tüm özelliklere erişebilirsiniz' : 'Temel özellikleri kullanabilirsiniz')
                        : 'Oturum açarak planınızı görün',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Gap(24.h),
            
            // Upgrade Banner (for free users)
            if (!isPremium && authState.isAuthenticated) ...[
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.rocket, color: Colors.white, size: 24.sp),
                        Gap(12.w),
                        Expanded(
                          child: Text(
                            'Bireysel Aboneliğe Geç',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(12.h),
                    Text(
                      'Tüm premium özelliklere erişim kazanın ve scouting deneyiminizi bir üst seviyeye taşıyın.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(16.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement subscription
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Yakında aktif olacak!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF6366F1),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Şimdi Abone Ol',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
            ],
            
            // Benefits Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PREMİUM AVANTAJLARI',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textGrey,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Gap(16.h),
            
            _buildFeatureTile(
              icon: LucideIcons.infinity,
              title: 'Sınırsız Rapor',
              desc: 'İstediğiniz kadar scout raporu oluşturun ve kaydedin.',
              active: isPremium,
            ),
            Gap(12.h),
            _buildFeatureTile(
              icon: LucideIcons.bot,
              title: 'AI Maç Analizi',
              desc: 'Yapay zeka destekli rakip analizi ve taktik önerileri.',
              active: isPremium,
            ),
            Gap(12.h),
            _buildFeatureTile(
              icon: LucideIcons.trendingUp,
              title: 'Gelişmiş İstatistikler',
              desc: 'Oyuncu performansı ve potansiyel büyüme analizleri.',
              active: isPremium,
            ),
            Gap(12.h),
            _buildFeatureTile(
              icon: LucideIcons.users,
              title: 'Takım Yönetimi',
              desc: 'Keşfettiğiniz yetenekleri organize edin ve yönetin.',
              active: isPremium,
            ),
            Gap(12.h),
            _buildFeatureTile(
              icon: LucideIcons.share2,
              title: 'Rapor Paylaşımı',
              desc: 'Raporlarınızı diğer scoutlarla paylaşın ve işbirliği yapın.',
              active: isPremium,
            ),
            Gap(12.h),
            _buildFeatureTile(
              icon: LucideIcons.download,
              title: 'PDF Dışa Aktarma',
              desc: 'Raporlarınızı profesyonel PDF formatında indirin.',
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? Colors.amber.withOpacity(0.3) : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: (active ? Colors.amber : AppTheme.textGrey).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: active ? Colors.amber : AppTheme.textGrey, size: 22.sp),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: active ? Colors.white : AppTheme.textGrey,
                        ),
                      ),
                    ),
                    if (active)
                      Icon(LucideIcons.check, color: Colors.amber, size: 18.sp),
                  ],
                ),
                Gap(4.h),
                Text(
                  desc,
                  style: TextStyle(
                    color: active ? AppTheme.textGrey : AppTheme.textGrey.withOpacity(0.5),
                    fontSize: 12.sp,
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
