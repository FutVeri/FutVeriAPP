import 'package:equatable/equatable.dart';

/// Match statistics entity
class MatchStatsEntity extends Equatable {
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

  const MatchStatsEntity({
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

  @override
  List<Object?> get props => [
        matchId,
        homeShots,
        awayShots,
        homeShotsOnTarget,
        awayShotsOnTarget,
        homePossession,
        awayPossession,
        homeXg,
        awayXg,
        homeCorners,
        awayCorners,
        homeFouls,
        awayFouls,
      ];
}
