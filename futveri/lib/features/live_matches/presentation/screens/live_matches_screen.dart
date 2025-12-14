import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../viewmodels/live_matches_viewmodel.dart';
import '../widgets/match_list_item.dart';

/// Live matches screen
class LiveMatchesScreen extends ConsumerWidget {
  const LiveMatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveMatchesViewModelProvider);
    final viewModel = ref.read(liveMatchesViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Matches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.refreshMatches(),
          ),
        ],
      ),
      body: _buildBody(context, state, viewModel),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBody(
    BuildContext context,
    LiveMatchesState state,
    LiveMatchesViewModel viewModel,
  ) {
    if (state.isLoading && state.matches.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.matches.isEmpty) {
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.loadMatches(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.matches.isEmpty) {
      return const Center(
        child: Text('No live matches at the moment'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.refreshMatches(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.matches.length,
        itemBuilder: (context, index) {
          final match = state.matches[index];
          return MatchListItem(
            match: match,
            onTap: () {
              context.push(
                AppRoutes.matchDetail.replaceAll(':matchId', match.id),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_soccer),
          label: 'Live',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Leagues',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gamepad),
          label: 'Sim',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.live);
            break;
          case 1:
            context.go(AppRoutes.leagues);
            break;
          case 2:
            context.go(AppRoutes.search);
            break;
          case 3:
            context.go(AppRoutes.simulation);
            break;
          case 4:
            context.go(AppRoutes.profile);
            break;
        }
      },
    );
  }
}
