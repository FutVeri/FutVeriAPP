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
    
    // Physical
    required int physicalRating,
    required String physicalDescription,

    // Technical
    required int technicalRating,
    required String technicalDescription,

    // Tactical
    required int tacticalRating,
    required String tacticalDescription,

    // Mental
    required int mentalRating,
    required String mentalDescription,

    // Overall
    required double overallRating,
    required double potentialRating,

    // SWOT
    required String strengths,
    required String weaknesses,
    required String risks,
    required String recommendedRole,
    
    // Meta
    required String scoutId,
    required DateTime createdAt,
    required String description,
    required List<String> imageUrls,
    @Default('draft') String status, // draft, submitted, approved
  }) = _ScoutReport;

  factory ScoutReport.fromJson(Map<String, dynamic> json) => _$ScoutReportFromJson(json);
}
