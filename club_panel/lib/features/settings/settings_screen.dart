import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../services/auth_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final club = authState.currentClub;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Ayarlar',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textWhite,
                  ),
            ),
            const Gap(4),
            Text(
              'Kulüp ayarlarını yönetin',
              style: TextStyle(
                color: AppTheme.textGrey.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
            const Gap(32),
            // Club Profile Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Expanded(
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.building2, color: AppTheme.primaryGreen, size: 20),
                            const Gap(12),
                            Text(
                              'Kulüp Profili',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textWhite,
                                  ),
                            ),
                          ],
                        ),
                        const Gap(24),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                              child: Text(
                                club?.name[0] ?? 'C',
                                style: const TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            const Gap(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  club?.name ?? 'Kulüp Adı',
                                  style: const TextStyle(
                                    color: AppTheme.textWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  club?.league ?? 'Lig',
                                  style: TextStyle(
                                    color: AppTheme.textGrey.withValues(alpha: 0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                const Gap(2),
                                Text(
                                  '${club?.city ?? ''}, ${club?.country ?? ''}',
                                  style: TextStyle(
                                    color: AppTheme.textGrey.withValues(alpha: 0.6),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(24),
                        _buildInfoRow(LucideIcons.mail, 'E-posta', club?.email ?? '-'),
                        const Gap(12),
                        _buildInfoRow(LucideIcons.calendar, 'Kayıt Tarihi', 
                            club?.createdAt != null 
                                ? '${club!.createdAt.day}/${club.createdAt.month}/${club.createdAt.year}' 
                                : '-'),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
                // Settings Options
                Expanded(
                  child: Column(
                    children: [
                      _buildSettingsCard(
                        context,
                        icon: LucideIcons.bell,
                        title: 'Bildirimler',
                        subtitle: 'Bildirim ayarlarını yönetin',
                        onTap: () {},
                      ),
                      const Gap(16),
                      _buildSettingsCard(
                        context,
                        icon: LucideIcons.shield,
                        title: 'Güvenlik',
                        subtitle: 'Şifre ve güvenlik ayarları',
                        onTap: () {},
                      ),
                      const Gap(16),
                      _buildSettingsCard(
                        context,
                        icon: LucideIcons.users,
                        title: 'Ekip Yönetimi',
                        subtitle: 'Kullanıcı ve yetki ayarları',
                        onTap: () {},
                      ),
                      const Gap(16),
                      _buildSettingsCard(
                        context,
                        icon: LucideIcons.creditCard,
                        title: 'Abonelik',
                        subtitle: 'Plan ve ödeme bilgileri',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.textGrey, size: 16),
        const Gap(12),
        Text(
          '$label:',
          style: const TextStyle(
            color: AppTheme.textGrey,
            fontSize: 13,
          ),
        ),
        const Gap(8),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textWhite,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppTheme.textGrey.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, color: AppTheme.textGrey, size: 18),
        ],
      ),
    );
  }
}
