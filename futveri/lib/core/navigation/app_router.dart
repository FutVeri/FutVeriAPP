import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/live_matches/presentation/screens/live_matches_screen.dart';
import '../../features/live_matches/presentation/screens/match_detail_screen.dart';

/// Routes
class AppRoutes {
  static const String live = '/live';
  static const String matchDetail = '/match/:matchId';
  static const String leagues = '/leagues';
  static const String search = '/search';
  static const String simulation = '/simulation';
  static const String profile = '/profile';
}

/// Router provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.live,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.live,
        builder: (context, state) => const LiveMatchesScreen(),
      ),
      GoRoute(
        path: AppRoutes.matchDetail,
        builder: (context, state) {
          final matchId = state.pathParameters['matchId']!;
          return MatchDetailScreen(matchId: matchId);
        },
      ),
      // TODO: Add other routes (leagues, search, simulation, profile)
      GoRoute(
        path: AppRoutes.leagues,
        builder: (context, state) => const _PlaceholderScreen(title: 'Leagues'),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const _PlaceholderScreen(title: 'Search'),
      ),
      GoRoute(
        path: AppRoutes.simulation,
        builder: (context, state) => const _PlaceholderScreen(title: 'Simulation'),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const _PlaceholderScreen(title: 'Profile'),
      ),
    ],
  );
});

/// Placeholder screen for routes not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title - Coming Soon',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
