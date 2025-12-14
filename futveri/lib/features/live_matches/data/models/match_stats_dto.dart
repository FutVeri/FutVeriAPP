import '../../domain/entities/match_stats_entity.dart';

/// Match stats DTO
class MatchStatsDto {
  final String matchId;
  final int homeShots;
  final int awayShots;
  final int homeShotsOnTarget;
  final int awayShotsOnTarget;
  final int homePossession;
  final int awayPossession;
  final double homeXg;
  final double awayXg;
  final int homeCorners;
  final int awayCorners;
  final int homeFouls;
  final int awayFouls;

  MatchStatsDto({
    required this.matchId,
    required this.homeShots,
    required this.awayShots,
    required this.homeShotsOnTarget,
    required this.awayShotsOnTarget,
    required this.homePossession,
    required this.awayPossession,
    required this.homeXg,
    required this.awayXg,
    required this.homeCorners,
    required this.awayCorners,
    required this.homeFouls,
    required this.awayFouls,
  });

  factory MatchStatsDto.fromJson(Map<String, dynamic> json) {
    return MatchStatsDto(
      matchId: json['matchId'] as String,
      homeShots: json['homeShots'] as int,
      awayShots: json['awayShots'] as int,
      homeShotsOnTarget: json['homeShotsOnTarget'] as int,
      awayShotsOnTarget: json['awayShotsOnTarget'] as int,
      homePossession: json['homePossession'] as int,
      awayPossession: json['awayPossession'] as int,
      homeXg: (json['homeXg'] as num).toDouble(),
      awayXg: (json['awayXg'] as num).toDouble(),
      homeCorners: json['homeCorners'] as int,
      awayCorners: json['awayCorners'] as int,
      homeFouls: json['homeFouls'] as int,
      awayFouls: json['awayFouls'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'homeShots': homeShots,
      'awayShots': awayShots,
      'homeShotsOnTarget': homeShotsOnTarget,
      'awayShotsOnTarget': awayShotsOnTarget,
      'homePossession': homePossession,
      'awayPossession': awayPossession,
      'homeXg': homeXg,
      'awayXg': awayXg,
      'homeCorners': homeCorners,
      'awayCorners': awayCorners,
      'homeFouls': homeFouls,
      'awayFouls': awayFouls,
    };
  }

  MatchStatsEntity toEntity() {
    return MatchStatsEntity(
      matchId: matchId,
      homeShots: homeShots,
      awayShots: awayShots,
      homeShotsOnTarget: homeShotsOnTarget,
      awayShotsOnTarget: awayShotsOnTarget,
      homePossession: homePossession,
      awayPossession: awayPossession,
      homeXg: homeXg,
      awayXg: awayXg,
      homeCorners: homeCorners,
      awayCorners: awayCorners,
      homeFouls: homeFouls,
      awayFouls: awayFouls,
    );
  }
}
