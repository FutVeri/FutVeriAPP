import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../services/mock_data_service.dart';
import 'widgets/stat_card.dart';
import 'widgets/activity_chart.dart';
import 'widgets/recent_reports_widget.dart';
import 'widgets/recent_users_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = MockDataService().getDashboardStats();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textWhite,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      'FutVeri Admin Paneline Hoş Geldiniz',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // System Status
                GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  borderRadius: 12,
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: stats.dbStatus
                              ? AppTheme.successGreen
                              : AppTheme.errorRed,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: (stats.dbStatus
                                      ? AppTheme.successGreen
                                      : AppTheme.errorRed)
                                  .withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'API: ${stats.apiResponseMs}ms',
                        style: const TextStyle(
                          color: AppTheme.textGrey,
                          fontSize: 13,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        'DB: ${stats.dbStatus ? "OK" : "Error"}',
                        style: TextStyle(
                          color: stats.dbStatus
                              ? AppTheme.successGreen
                              : AppTheme.errorRed,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(32),
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: LucideIcons.users,
                    label: 'Toplam Kullanıcı',
                    value: stats.totalUsers.toString(),
                    trend: '+12%',
                    trendUp: true,
                    accentColor: AppTheme.primaryGreen,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: StatCard(
                    icon: LucideIcons.activity,
                    label: 'Günlük Aktif',
                    value: stats.dailyActiveUsers.toString(),
                    trend: '+5%',
                    trendUp: true,
                    accentColor: AppTheme.secondaryBlue,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: StatCard(
                    icon: LucideIcons.wifi,
                    label: 'Online',
                    value: stats.onlineUsers.toString(),
                    accentColor: AppTheme.successGreen,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: StatCard(
                    icon: LucideIcons.fileText,
                    label: 'Bekleyen Rapor',
                    value: stats.pendingReports.toString(),
                    accentColor: AppTheme.warningOrange,
                  ),
                ),
              ],
            ),
            const Gap(24),
            // Charts and Lists Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Activity Chart
                Expanded(
                  flex: 2,
                  child: ActivityChart(data: stats.weeklyActivity),
                ),
                const Gap(16),
                // Recent Reports and Users
                Expanded(
                  child: Column(
                    children: [
                      RecentReportsWidget(
                        reports: MockDataService().getScoutReports().take(5).toList(),
                      ),
                      const Gap(16),
                      RecentUsersWidget(
                        users: MockDataService().getUsers().take(5).toList(),
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
}
