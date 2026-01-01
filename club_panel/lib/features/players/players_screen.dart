import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/club.dart';
import '../../services/mock_data_service.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  final _searchController = TextEditingController();
  String _selectedPosition = 'Tümü';
  final _positions = ['Tümü', 'Orta Saha', 'Kanat', 'Forvet', 'Defans', 'Kaleci'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final players = MockDataService().getPlayers();
    final filteredPlayers = players.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesPosition = _selectedPosition == 'Tümü' || 
          p.position.toLowerCase().contains(_selectedPosition.toLowerCase());
      return matchesSearch && matchesPosition;
    }).toList();

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
                      'Oyuncular',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textWhite,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      '${players.length} oyuncu takip ediliyor',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Search
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(color: AppTheme.textWhite),
                    decoration: InputDecoration(
                      hintText: 'Oyuncu ara...',
                      hintStyle: TextStyle(color: AppTheme.textGrey.withValues(alpha: 0.5)),
                      prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textGrey, size: 18),
                      filled: true,
                      fillColor: AppTheme.surfaceDark,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const Gap(16),
                // Position Filter
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.glassBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPosition,
                      dropdownColor: AppTheme.surfaceDark,
                      style: const TextStyle(color: AppTheme.textWhite),
                      icon: const Icon(LucideIcons.chevronDown, color: AppTheme.textGrey, size: 18),
                      items: _positions.map((p) => DropdownMenuItem(
                        value: p,
                        child: Text(p),
                      )).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedPosition = value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Gap(24),
            // Players Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredPlayers.length,
                itemBuilder: (context, index) {
                  return _buildPlayerCard(filteredPlayers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerCard(Player player) {
    return GlassCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                child: Text(
                  player.name.split(' ').map((n) => n[0]).join(),
                  style: const TextStyle(
                    color: AppTheme.primaryGreen,
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
                      player.name,
                      style: const TextStyle(
                        color: AppTheme.textWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      player.currentClub,
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (player.averageRating != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    player.averageRating!.toStringAsFixed(1),
                    style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              _buildInfoChip(LucideIcons.calendar, '${player.age} yaş'),
              const Gap(8),
              _buildInfoChip(LucideIcons.mapPin, player.position),
              const Spacer(),
              _buildInfoChip(LucideIcons.fileText, '${player.reportsCount} rapor'),
            ],
          ),
          const Gap(12),
          if (player.marketValue != null)
            Text(
              '€${(player.marketValue! / 1000000).toStringAsFixed(1)}M',
              style: const TextStyle(
                color: AppTheme.secondaryBlue,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.textGrey, size: 12),
          const Gap(4),
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
