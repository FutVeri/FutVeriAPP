import 'package:freezed_annotation/freezed_annotation.dart';

part 'scout_report.freezed.dart';
part 'scout_report.g.dart';

@freezed
abstract class ScoutReport with _$ScoutReport {
  const factory ScoutReport({
    required String id,
    required String playerId,
    required String playerName,
    required String playerPosition,
    required int playerAge,
    required String playerTeam,
    
    // Match Context
    required DateTime matchDate,
    required String rivalTeam,
    required String score,
    required int minutePlayed,
    required String matchType, // Stadium, TV, etc.
    
    // Ratings (Map of parameter name to score 1-10)
    required Map<String, int> ratings,
    
    // Analysis
    required String physicalAttributes,
    required String technicalAttributes,
    required String tacticalAttributes,
    required String metalAttributes,
    
    // SWOT
    required String strengths,
    required String weaknesses,
    required String risks,
    required String recommendedRole,
    
    // Meta
    required String scoutId,
    required DateTime createdAt,
    @Default('draft') String status, // draft, submitted, approved
  }) = _ScoutReport;

  factory ScoutReport.fromJson(Map<String, dynamic> json) => _$ScoutReportFromJson(json);
}
