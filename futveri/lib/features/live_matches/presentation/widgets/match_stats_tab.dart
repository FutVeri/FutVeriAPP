import 'package:flutter/material.dart';
import '../../domain/entities/match_stats_entity.dart';

/// Match statistics tab
class MatchStatsTab extends StatelessWidget {
  final MatchStatsEntity stats;

  const MatchStatsTab({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _StatRow(
          label: 'Possession',
          homeValue: '${stats.homePossession}%',
          awayValue: '${stats.awayPossession}%',
          homePercent: stats.homePossession / 100,
        ),
        _StatRow(
          label: 'Shots',
          homeValue: stats.homeShots.toString(),
          awayValue: stats.awayShots.toString(),
          homePercent: stats.homeShots / (stats.homeShots + stats.awayShots),
        ),
        _StatRow(
          label: 'Shots on Target',
          homeValue: stats.homeShotsOnTarget.toString(),
          awayValue: stats.awayShotsOnTarget.toString(),
          homePercent: stats.homeShotsOnTarget /
              (stats.homeShotsOnTarget + stats.awayShotsOnTarget),
        ),
        _StatRow(
          label: 'Expected Goals (xG)',
          homeValue: stats.homeXg.toStringAsFixed(2),
          awayValue: stats.awayXg.toStringAsFixed(2),
          homePercent: stats.homeXg / (stats.homeXg + stats.awayXg),
        ),
        _StatRow(
          label: 'Corners',
          homeValue: stats.homeCorners.toString(),
          awayValue: stats.awayCorners.toString(),
          homePercent: stats.homeCorners / (stats.homeCorners + stats.awayCorners),
        ),
        _StatRow(
          label: 'Fouls',
          homeValue: stats.homeFouls.toString(),
          awayValue: stats.awayFouls.toString(),
          homePercent: stats.homeFouls / (stats.homeFouls + stats.awayFouls),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String homeValue;
  final String awayValue;
  final double homePercent;

  const _StatRow({
    required this.label,
    required this.homeValue,
    required this.awayValue,
    required this.homePercent,
  });

  @override
  Widget build(BuildContext context) {
    final awayPercent = 1 - homePercent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          // Label
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          
          // Values
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeValue,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                awayValue,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(
              children: [
                Expanded(
                  flex: (homePercent * 100).toInt(),
                  child: Container(
                    height: 8,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                  flex: (awayPercent * 100).toInt(),
                  child: Container(
                    height: 8,
                    color: Theme.of(context).colorScheme.error,
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
