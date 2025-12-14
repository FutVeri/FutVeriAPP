import 'package:equatable/equatable.dart';
import 'team_entity.dart';

/// Match status
enum MatchStatus {
  scheduled,
  live,
  halftime,
  finished,
  postponed,
  cancelled,
}

/// Match entity
class MatchEntity extends Equatable {
  final String id;
  final TeamEntity homeTeam;
  final TeamEntity awayTeam;
  final int homeScore;
  final int awayScore;
  final MatchStatus status;
  final int? minute;
  final DateTime startTime;
  final String? league;
  final String? venue;

  const MatchEntity({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    this.minute,
    required this.startTime,
    this.league,
    this.venue,
  });

  bool get isLive => status == MatchStatus.live || status == MatchStatus.halftime;

  @override
  List<Object?> get props => [
        id,
        homeTeam,
        awayTeam,
        homeScore,
        awayScore,
        status,
        minute,
        startTime,
        league,
        venue,
      ];
}
