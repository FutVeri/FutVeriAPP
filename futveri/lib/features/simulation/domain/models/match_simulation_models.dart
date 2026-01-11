/// Match Simulation Models for 2D FM-style match simulation
/// These models handle real-time match state, events, and player positions

import 'simulation_models.dart';

/// Match event types
enum MatchEventType {
  kickoff,
  goal,
  assist,
  shot,
  shotOnTarget,
  save,
  foul,
  yellowCard,
  redCard,
  substitution,
  corner,
  offside,
  freeKick,
  penalty,
  penaltyMiss,
  halfTime,
  fullTime,
  injury,
  possession,
}

/// A single match event during simulation
class MatchEvent {
  final int minute;
  final MatchEventType type;
  final String? playerId;
  final String? playerName;
  final String teamId;
  final String description;
  final DateTime timestamp;

  const MatchEvent({
    required this.minute,
    required this.type,
    this.playerId,
    this.playerName,
    required this.teamId,
    required this.description,
    required this.timestamp,
  });
}

/// Player position on 2D field (0-100 for both x and y)
class PlayerPosition {
  final String playerId;
  final String playerName;
  final int shirtNumber;
  final double x; // 0-100 (left to right)
  final double y; // 0-100 (bottom to top)
  final bool hasBall;
  final String position; // GK, CB, LB, RB, CM, etc.

  const PlayerPosition({
    required this.playerId,
    required this.playerName,
    required this.shirtNumber,
    required this.x,
    required this.y,
    this.hasBall = false,
    required this.position,
  });

  PlayerPosition copyWith({
    double? x,
    double? y,
    bool? hasBall,
  }) {
    return PlayerPosition(
      playerId: playerId,
      playerName: playerName,
      shirtNumber: shirtNumber,
      x: x ?? this.x,
      y: y ?? this.y,
      hasBall: hasBall ?? this.hasBall,
      position: position,
    );
  }
}

/// Weekly match fixture
class WeeklyMatch {
  final String id;
  final SimulationTeam homeTeam;
  final SimulationTeam awayTeam;
  final DateTime matchDateTime;
  final String stadium;
  final int matchweek;
  final String competition;

  const WeeklyMatch({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDateTime,
    required this.stadium,
    required this.matchweek,
    this.competition = 'Süper Lig',
  });
}

/// Current match state during simulation
class MatchState {
  final String matchId;
  final SimulationTeam homeTeam;
  final SimulationTeam awayTeam;
  final String userTeamId; // Which team user is coaching
  final int minute;
  final int homeScore;
  final int awayScore;
  final double homePossession;
  final int homeShots;
  final int awayShots;
  final int homeShotsOnTarget;
  final int awayShotsOnTarget;
  final int homeCorners;
  final int awayCorners;
  final int homeFouls;
  final int awayFouls;
  final int homeYellowCards;
  final int awayYellowCards;
  final int homeRedCards;
  final int awayRedCards;
  final List<MatchEvent> events;
  final List<PlayerPosition> homePositions;
  final List<PlayerPosition> awayPositions;
  final List<SimulationPlayer>? _homeBench;
  final List<SimulationPlayer>? _awayBench;
  
  List<SimulationPlayer> get homeBench => _homeBench ?? const [];
  List<SimulationPlayer> get awayBench => _awayBench ?? const [];

  final bool isPlaying;
  final bool isHalfTime;
  final bool isFullTime;
  final String? currentTactic; // defensive, balanced, attacking
  final int? _speedMultiplier;

  int get speedMultiplier => _speedMultiplier ?? 1;

  const MatchState({
    required this.matchId,
    required this.homeTeam,
    required this.awayTeam,
    required this.userTeamId,
    this.minute = 0,
    this.homeScore = 0,
    this.awayScore = 0,
    this.homePossession = 50.0,
    this.homeShots = 0,
    this.awayShots = 0,
    this.homeShotsOnTarget = 0,
    this.awayShotsOnTarget = 0,
    this.homeCorners = 0,
    this.awayCorners = 0,
    this.homeFouls = 0,
    this.awayFouls = 0,
    this.homeYellowCards = 0,
    this.awayYellowCards = 0,
    this.homeRedCards = 0,
    this.awayRedCards = 0,
    this.events = const [],
    this.homePositions = const [],
    this.awayPositions = const [],
    List<SimulationPlayer>? homeBench,
    List<SimulationPlayer>? awayBench,
    this.isPlaying = false,
    this.isHalfTime = false,
    this.isFullTime = false,
    this.currentTactic = 'balanced',
    int? speedMultiplier = 1,
  }) : _homeBench = homeBench, _awayBench = awayBench, _speedMultiplier = speedMultiplier;

  MatchState copyWith({
    int? minute,
    int? homeScore,
    int? awayScore,
    double? homePossession,
    int? homeShots,
    int? awayShots,
    int? homeShotsOnTarget,
    int? awayShotsOnTarget,
    int? homeCorners,
    int? awayCorners,
    int? homeFouls,
    int? awayFouls,
    int? homeYellowCards,
    int? awayYellowCards,
    int? homeRedCards,
    int? awayRedCards,
    List<MatchEvent>? events,
    List<PlayerPosition>? homePositions,
    List<PlayerPosition>? awayPositions,
    List<SimulationPlayer>? homeBench,
    List<SimulationPlayer>? awayBench,
    bool? isPlaying,
    bool? isHalfTime,
    bool? isFullTime,
    String? currentTactic,
    int? speedMultiplier,
  }) {
    return MatchState(
      matchId: matchId,
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      userTeamId: userTeamId,
      minute: minute ?? this.minute,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      homePossession: homePossession ?? this.homePossession,
      homeShots: homeShots ?? this.homeShots,
      awayShots: awayShots ?? this.awayShots,
      homeShotsOnTarget: homeShotsOnTarget ?? this.homeShotsOnTarget,
      awayShotsOnTarget: awayShotsOnTarget ?? this.awayShotsOnTarget,
      homeCorners: homeCorners ?? this.homeCorners,
      awayCorners: awayCorners ?? this.awayCorners,
      homeFouls: homeFouls ?? this.homeFouls,
      awayFouls: awayFouls ?? this.awayFouls,
      homeYellowCards: homeYellowCards ?? this.homeYellowCards,
      awayYellowCards: awayYellowCards ?? this.awayYellowCards,
      homeRedCards: homeRedCards ?? this.homeRedCards,
      awayRedCards: awayRedCards ?? this.awayRedCards,
      events: events ?? this.events,
      homePositions: homePositions ?? this.homePositions,
      awayPositions: awayPositions ?? this.awayPositions,
      homeBench: homeBench ?? this.homeBench,
      awayBench: awayBench ?? this.awayBench,
      isPlaying: isPlaying ?? this.isPlaying,
      isHalfTime: isHalfTime ?? this.isHalfTime,
      isFullTime: isFullTime ?? this.isFullTime,
      currentTactic: currentTactic ?? this.currentTactic,
      speedMultiplier: speedMultiplier ?? this.speedMultiplier,
    );
  }
}

/// Tactical intervention by user during match
class TacticalIntervention {
  final String type; // formation, substitution, mentality, instruction
  final String? newFormation;
  final String? playerOutId;
  final String? playerInId;
  final String? mentality; // defensive, balanced, attacking
  final String? instruction; // press high, sit deep, play wide, etc.

  const TacticalIntervention({
    required this.type,
    this.newFormation,
    this.playerOutId,
    this.playerInId,
    this.mentality,
    this.instruction,
  });
}

/// Formation presets
class FormationPreset {
  final String name;
  final List<List<int>> positions; // [GK, DEF count, MID count, FW count]

  const FormationPreset({required this.name, required this.positions});

  static const formations = [
    FormationPreset(name: '4-4-2', positions: [[1], [4], [4], [2]]),
    FormationPreset(name: '4-3-3', positions: [[1], [4], [3], [3]]),
    FormationPreset(name: '4-2-3-1', positions: [[1], [4], [2, 3], [1]]),
    FormationPreset(name: '3-5-2', positions: [[1], [3], [5], [2]]),
    FormationPreset(name: '5-3-2', positions: [[1], [5], [3], [2]]),
    FormationPreset(name: '4-1-4-1', positions: [[1], [4], [1, 4], [1]]),
  ];
}
