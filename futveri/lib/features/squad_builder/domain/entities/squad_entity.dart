import 'package:equatable/equatable.dart';
import 'player_entity.dart';
import 'formation_entity.dart';
import 'position.dart';

/// Squad entity
class SquadEntity extends Equatable {
  final String id;
  final String name;
  final FormationEntity formation;
  final Map<Position, PlayerEntity?> lineup; // Position -> Player mapping
  final List<PlayerEntity> bench;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SquadEntity({
    required this.id,
    required this.name,
    required this.formation,
    required this.lineup,
    this.bench = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create empty squad with formation
  factory SquadEntity.empty({
    required String id,
    required String name,
    required FormationEntity formation,
  }) {
    final now = DateTime.now();
    final lineup = <Position, PlayerEntity?>{};
    
    // Initialize all positions as empty
    for (final pitchPosition in formation.positions) {
      lineup[pitchPosition.position] = null;
    }
    
    return SquadEntity(
      id: id,
      name: name,
      formation: formation,
      lineup: lineup,
      bench: [],
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Get player at position
  PlayerEntity? getPlayerAt(Position position) {
    return lineup[position];
  }

  /// Set player at position
  SquadEntity setPlayerAt(Position position, PlayerEntity? player) {
    final newLineup = Map<Position, PlayerEntity?>.from(lineup);
    newLineup[position] = player;
    
    return copyWith(
      lineup: newLineup,
      updatedAt: DateTime.now(),
    );
  }

  /// Add player to bench
  SquadEntity addToBench(PlayerEntity player) {
    return copyWith(
      bench: [...bench, player],
      updatedAt: DateTime.now(),
    );
  }

  /// Remove player from bench
  SquadEntity removeFromBench(PlayerEntity player) {
    return copyWith(
      bench: bench.where((p) => p.id != player.id).toList(),
      updatedAt: DateTime.now(),
    );
  }

  /// Change formation
  SquadEntity changeFormation(FormationEntity newFormation) {
    final newLineup = <Position, PlayerEntity?>{};
    
    // Try to keep players in compatible positions
    for (final pitchPosition in newFormation.positions) {
      final position = pitchPosition.position;
      
      // Check if we have a player in this exact position
      if (lineup.containsKey(position) && lineup[position] != null) {
        newLineup[position] = lineup[position];
      } else {
        // Try to find a compatible player from old lineup
        final compatiblePlayer = lineup.entries
            .where((entry) => 
                entry.value != null && 
                entry.value!.canPlayIn(position) &&
                !newLineup.containsValue(entry.value))
            .firstOrNull;
        
        newLineup[position] = compatiblePlayer?.value;
      }
    }
    
    // Move unassigned players to bench
    final unassignedPlayers = lineup.values
        .where((player) => player != null && !newLineup.containsValue(player))
        .cast<PlayerEntity>()
        .toList();
    
    return copyWith(
      formation: newFormation,
      lineup: newLineup,
      bench: [...bench, ...unassignedPlayers],
      updatedAt: DateTime.now(),
    );
  }

  /// Get all players in squad (lineup + bench)
  List<PlayerEntity> get allPlayers {
    final players = <PlayerEntity>[];
    players.addAll(lineup.values.whereType<PlayerEntity>());
    players.addAll(bench);
    return players;
  }

  /// Get number of filled positions
  int get filledPositions {
    return lineup.values.where((player) => player != null).length;
  }

  /// Check if squad is complete (all positions filled)
  bool get isComplete {
    return filledPositions == lineup.length;
  }

  /// Calculate average squad rating
  double get averageRating {
    final players = lineup.values.whereType<PlayerEntity>().toList();
    if (players.isEmpty) return 0.0;
    
    final totalRating = players.fold<int>(
      0,
      (sum, player) => sum + player.overallRating,
    );
    
    return totalRating / players.length;
  }

  /// Calculate squad chemistry (simplified version)
  /// In a real app, this would consider nationality, league, club links
  int get chemistry {
    if (!isComplete) return 0;
    
    int chemistryPoints = 0;
    final players = lineup.entries.where((e) => e.value != null).toList();
    
    for (final entry in players) {
      final position = entry.key;
      final player = entry.value!;
      
      // Position chemistry (0-10)
      if (player.primaryPosition == position) {
        chemistryPoints += 10;
      } else if (player.alternativePositions.contains(position)) {
        chemistryPoints += 7;
      } else if (player.canPlayIn(position)) {
        chemistryPoints += 4;
      } else {
        chemistryPoints += 1;
      }
    }
    
    // Return percentage (0-100)
    final maxChemistry = players.length * 10;
    return ((chemistryPoints / maxChemistry) * 100).round();
  }

  /// Copy with method
  SquadEntity copyWith({
    String? id,
    String? name,
    FormationEntity? formation,
    Map<Position, PlayerEntity?>? lineup,
    List<PlayerEntity>? bench,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SquadEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      formation: formation ?? this.formation,
      lineup: lineup ?? this.lineup,
      bench: bench ?? this.bench,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        formation,
        lineup,
        bench,
        createdAt,
        updatedAt,
      ];
}
