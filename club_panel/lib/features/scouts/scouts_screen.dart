import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/club.dart';
import '../../services/mock_data_service.dart';

class ScoutsScreen extends StatelessWidget {
  const ScoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scouts = MockDataService().getScouts();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
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
                      'Scoutlar',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textWhite,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      '${scouts.length} scout kayıtlı',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.userPlus, size: 18),
                  label: const Text('Scout Ekle'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                ),
              ],
            ),
            const Gap(24),
            // Scouts Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: scouts.length,
                itemBuilder: (context, index) {
                  return _buildScoutCard(scouts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoutCard(Scout scout) {
    return GlassCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: scout.isActive 
                    ? AppTheme.primaryGreen.withValues(alpha: 0.2)
                    : AppTheme.surfaceLight,
                child: Text(
                  scout.name.split(' ').map((n) => n[0]).join(),
                  style: TextStyle(
                    color: scout.isActive ? AppTheme.primaryGreen : AppTheme.textGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scout.name,
                      style: const TextStyle(
                        color: AppTheme.textWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      scout.email,
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: scout.isActive 
                      ? AppTheme.successGreen.withValues(alpha: 0.15)
                      : AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: scout.isActive ? AppTheme.successGreen : AppTheme.textGrey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      scout.isActive ? 'Aktif' : 'Pasif',
                      style: TextStyle(
                        color: scout.isActive ? AppTheme.successGreen : AppTheme.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildStatItem(LucideIcons.mapPin, scout.region),
              const Gap(12),
              _buildStatItem(LucideIcons.fileText, '${scout.totalReports} rapor'),
              const Gap(12),
              _buildStatItem(LucideIcons.target, '${scout.activeAssignments} görev'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.textGrey, size: 12),
          const Gap(6),
          Text(
            text,
            style: const TextStyle(
              color: AppTheme.textGrey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
