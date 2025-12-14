import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/match_entity.dart';
import '../providers/live_matches_providers.dart';

/// Live matches state
class LiveMatchesState {
  final List<MatchEntity> matches;
  final bool isLoading;
  final String? error;

  LiveMatchesState({
    this.matches = const [],
    this.isLoading = false,
    this.error,
  });

  LiveMatchesState copyWith({
    List<MatchEntity>? matches,
    bool? isLoading,
    String? error,
  }) {
    return LiveMatchesState(
      matches: matches ?? this.matches,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Live matches ViewModel
class LiveMatchesViewModel extends StateNotifier<LiveMatchesState> {
  final GetLiveMatchesUseCase getLiveMatchesUseCase;

  LiveMatchesViewModel(this.getLiveMatchesUseCase) : super(LiveMatchesState()) {
    // Auto-load on initialization
    loadMatches();
  }

  /// Load live matches
  Future<void> loadMatches() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await getLiveMatchesUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Failed to load matches: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (matches) {
        AppLogger.info('Loaded ${matches.length} matches');
        state = state.copyWith(
          matches: matches,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Refresh matches (pull-to-refresh)
  Future<void> refreshMatches() async {
    await loadMatches();
  }
}

/// Provider for LiveMatchesViewModel
final liveMatchesViewModelProvider =
    StateNotifierProvider<LiveMatchesViewModel, LiveMatchesState>((ref) {
  return LiveMatchesViewModel(
    ref.watch(getLiveMatchesUseCaseProvider),
  );
});
