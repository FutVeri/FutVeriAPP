import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/usecases/get_match_detail_usecase.dart';
import '../providers/live_matches_providers.dart';

/// Match detail state
class MatchDetailState {
  final MatchDetail? matchDetail;
  final bool isLoading;
  final String? error;

  MatchDetailState({
    this.matchDetail,
    this.isLoading = false,
    this.error,
  });

  MatchDetailState copyWith({
    MatchDetail? matchDetail,
    bool? isLoading,
    String? error,
  }) {
    return MatchDetailState(
      matchDetail: matchDetail ?? this.matchDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Match detail ViewModel
class MatchDetailViewModel extends StateNotifier<MatchDetailState> {
  final GetMatchDetailUseCase getMatchDetailUseCase;
  final String matchId;

  MatchDetailViewModel({
    required this.getMatchDetailUseCase,
    required this.matchId,
  }) : super(MatchDetailState()) {
    loadMatchDetail();
  }

  /// Load match detail
  Future<void> loadMatchDetail() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await getMatchDetailUseCase(matchId);

    result.fold(
      (failure) {
        AppLogger.error('Failed to load match detail: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (matchDetail) {
        AppLogger.info('Loaded match detail for $matchId');
        state = state.copyWith(
          matchDetail: matchDetail,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Refresh match detail
  Future<void> refresh() async {
    await loadMatchDetail();
  }
}

/// Provider factory for MatchDetailViewModel
final matchDetailViewModelProvider = StateNotifierProvider.family<
    MatchDetailViewModel, MatchDetailState, String>((ref, matchId) {
  return MatchDetailViewModel(
    getMatchDetailUseCase: ref.watch(getMatchDetailUseCaseProvider),
    matchId: matchId,
  );
});
