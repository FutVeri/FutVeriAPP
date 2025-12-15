import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/formation_entity.dart';
import '../../domain/entities/squad_entity.dart';
import '../../domain/entities/position.dart';
import '../providers/squad_providers.dart';

/// Squad builder state
class SquadBuilderState {
  final SquadEntity squad;
  final List<PlayerEntity> availablePlayers;
  final List<FormationEntity> formations;
  final bool isLoading;
  final String? error;
  final String? searchQuery;
  final Position? filterPosition;

  SquadBuilderState({
    required this.squad,
    this.availablePlayers = const [],
    this.formations = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery,
    this.filterPosition,
  });

  SquadBuilderState copyWith({
    SquadEntity? squad,
    List<PlayerEntity>? availablePlayers,
    List<FormationEntity>? formations,
    bool? isLoading,
    String? error,
    String? searchQuery,
    Position? filterPosition,
    bool clearError = false,
    bool clearFilter = false,
  }) {
    return SquadBuilderState(
      squad: squad ?? this.squad,
      availablePlayers: availablePlayers ?? this.availablePlayers,
      formations: formations ?? this.formations,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      searchQuery: searchQuery ?? this.searchQuery,
      filterPosition: clearFilter ? null : (filterPosition ?? this.filterPosition),
    );
  }

  /// Get filtered players
  List<PlayerEntity> get filteredPlayers {
    var players = availablePlayers;

    // Filter by search query
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      players = players
          .where((p) => p.name.toLowerCase().contains(searchQuery!.toLowerCase()))
          .toList();
    }

    // Filter by position
    if (filterPosition != null) {
      players = players.where((p) => p.canPlayIn(filterPosition!)).toList();
    }

    // Remove players already in squad
    final squadPlayerIds = squad.allPlayers.map((p) => p.id).toSet();
    players = players.where((p) => !squadPlayerIds.contains(p.id)).toList();

    // Sort by rating
    players.sort((a, b) => b.overallRating.compareTo(a.overallRating));

    return players;
  }
}

/// Squad builder view model
class SquadBuilderViewModel extends StateNotifier<SquadBuilderState> {
  final Ref ref;

  SquadBuilderViewModel(this.ref)
      : super(SquadBuilderState(
          squad: SquadEntity.empty(
            id: 'squad_1',
            name: 'My Squad',
            formation: FormationEntity.formation433,
          ),
        )) {
    _initialize();
  }

  /// Initialize data
  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Load formations
      final formationsResult = await ref.read(getFormationsUseCaseProvider).call();
      formationsResult.fold(
        (failure) => throw Exception(failure.message),
        (formations) {
          state = state.copyWith(formations: formations);
        },
      );

      // Load available players
      final playersResult = await ref.read(getAvailablePlayersUseCaseProvider).call();
      playersResult.fold(
        (failure) => throw Exception(failure.message),
        (players) {
          state = state.copyWith(availablePlayers: players);
        },
      );

      // Try to load saved squad
      final squadResult = await ref.read(loadSquadUseCaseProvider).call('user_1');
      squadResult.fold(
        (failure) => AppLogger.warning('No saved squad found'),
        (savedSquad) {
          if (savedSquad != null) {
            state = state.copyWith(squad: savedSquad);
          }
        },
      );

      state = state.copyWith(isLoading: false);
    } catch (e) {
      AppLogger.error('Failed to initialize squad builder', e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Set player at position
  void setPlayerAtPosition(Position position, PlayerEntity player) {
    final updatedSquad = state.squad.setPlayerAt(position, player);
    state = state.copyWith(squad: updatedSquad);
    AppLogger.info('Player ${player.name} set at $position');
  }

  /// Remove player from position
  void removePlayerFromPosition(Position position) {
    final updatedSquad = state.squad.setPlayerAt(position, null);
    state = state.copyWith(squad: updatedSquad);
    AppLogger.info('Player removed from $position');
  }

  /// Change formation
  void changeFormation(FormationEntity formation) {
    final updatedSquad = state.squad.changeFormation(formation);
    state = state.copyWith(squad: updatedSquad);
    AppLogger.info('Formation changed to ${formation.name}');
  }

  /// Add player to bench
  void addPlayerToBench(PlayerEntity player) {
    final updatedSquad = state.squad.addToBench(player);
    state = state.copyWith(squad: updatedSquad);
    AppLogger.info('Player ${player.name} added to bench');
  }

  /// Remove player from bench
  void removePlayerFromBench(PlayerEntity player) {
    final updatedSquad = state.squad.removeFromBench(player);
    state = state.copyWith(squad: updatedSquad);
    AppLogger.info('Player ${player.name} removed from bench');
  }

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Set position filter
  void setPositionFilter(Position? position) {
    state = state.copyWith(
      filterPosition: position,
      clearFilter: position == null,
    );
  }

  /// Clear filters
  void clearFilters() {
    state = state.copyWith(
      searchQuery: '',
      clearFilter: true,
    );
  }

  /// Save squad
  Future<void> saveSquad() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final result = await ref.read(saveSquadUseCaseProvider).call(state.squad);
      result.fold(
        (failure) => throw Exception(failure.message),
        (_) {
          AppLogger.info('Squad saved successfully');
          state = state.copyWith(isLoading: false);
        },
      );
    } catch (e) {
      AppLogger.error('Failed to save squad', e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Reset squad
  void resetSquad() {
    state = state.copyWith(
      squad: SquadEntity.empty(
        id: 'squad_1',
        name: 'My Squad',
        formation: state.squad.formation,
      ),
    );
    AppLogger.info('Squad reset');
  }
}

/// Squad builder view model provider
final squadBuilderViewModelProvider =
    StateNotifierProvider<SquadBuilderViewModel, SquadBuilderState>((ref) {
  return SquadBuilderViewModel(ref);
});
