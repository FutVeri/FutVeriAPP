import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/match_detail_viewmodel.dart';
import '../widgets/match_scoreboard.dart';
import '../widgets/match_events_tab.dart';
import '../widgets/match_stats_tab.dart';

/// Match detail screen with tabs
class MatchDetailScreen extends ConsumerWidget {
  final String matchId;

  const MatchDetailScreen({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailViewModelProvider(matchId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(matchDetailViewModelProvider(matchId).notifier).refresh();
            },
          ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, MatchDetailState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: ${state.error}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.matchDetail == null) {
      return const Center(child: Text('No match data'));
    }

    final matchDetail = state.matchDetail!;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // Scoreboard header
          MatchScoreboard(match: matchDetail.match),
          
          // Tabs
          const TabBar(
            tabs: [
              Tab(text: 'Events'),
              Tab(text: 'Stats'),
              Tab(text: 'AI Analysis'),
            ],
          ),
          
          // Tab views
          Expanded(
            child: TabBarView(
              children: [
                MatchEventsTab(events: matchDetail.events),
                MatchStatsTab(stats: matchDetail.stats),
                _buildAiTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiTab(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.psychology, size: 64, color: Colors.purple),
            const SizedBox(height: 16),
            Text(
              'AI Match Analysis',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon: AI-powered match insights, tactical analysis, and key moments',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
