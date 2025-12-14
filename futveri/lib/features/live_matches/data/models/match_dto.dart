import '../../domain/entities/match_entity.dart';
import 'team_dto.dart';

/// Match DTO
class MatchDto {
  final String id;
  final TeamDto homeTeam;
  final TeamDto awayTeam;
  final int homeScore;
  final int awayScore;
  final String status;
  final int? minute;
  final DateTime startTime;
  final String? league;
  final String? venue;

  MatchDto({
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

  factory MatchDto.fromJson(Map<String, dynamic> json) {
    return MatchDto(
      id: json['id'] as String,
      homeTeam: TeamDto.fromJson(json['homeTeam'] as Map<String, dynamic>),
      awayTeam: TeamDto.fromJson(json['awayTeam'] as Map<String, dynamic>),
      homeScore: json['homeScore'] as int,
      awayScore: json['awayScore'] as int,
      status: json['status'] as String,
      minute: json['minute'] as int?,
      startTime: DateTime.parse(json['startTime'] as String),
      league: json['league'] as String?,
      venue: json['venue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homeTeam': homeTeam.toJson(),
      'awayTeam': awayTeam.toJson(),
      'homeScore': homeScore,
      'awayScore': awayScore,
      'status': status,
      'minute': minute,
      'startTime': startTime.toIso8601String(),
      'league': league,
      'venue': venue,
    };
  }

  MatchEntity toEntity() {
    return MatchEntity(
      id: id,
      homeTeam: homeTeam.toEntity(),
      awayTeam: awayTeam.toEntity(),
      homeScore: homeScore,
      awayScore: awayScore,
      status: _parseStatus(status),
      minute: minute,
      startTime: startTime,
      league: league,
      venue: venue,
    );
  }

  MatchStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'live':
        return MatchStatus.live;
      case 'halftime':
        return MatchStatus.halftime;
      case 'finished':
        return MatchStatus.finished;
      case 'scheduled':
        return MatchStatus.scheduled;
      case 'postponed':
        return MatchStatus.postponed;
      case 'cancelled':
        return MatchStatus.cancelled;
      default:
        return MatchStatus.scheduled;
    }
  }
}
