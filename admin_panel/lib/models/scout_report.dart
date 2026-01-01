/// Scout Report model - synced with mobile app
/// Status field: draft, submitted, approved, rejected
class ScoutReport {
  final String id;
  final String playerId;
  final String playerName;
  final String playerPosition;
  final int playerAge;
  final String playerTeam;

  // Match Context
  final DateTime matchDate;
  final String rivalTeam;
  final String score;
  final int minutePlayed;
  final String matchType; // Stadium, TV, etc.

  // Physical
  final int physicalRating;
  final String physicalDescription;

  // Technical
  final int technicalRating;
  final String technicalDescription;

  // Tactical
  final int tacticalRating;
  final String tacticalDescription;

  // Mental
  final int mentalRating;
  final String mentalDescription;

  // Overall
  final double overallRating;
  final double potentialRating;

  // SWOT
  final String strengths;
  final String weaknesses;
  final String risks;
  final String recommendedRole;

  // Meta
  final String scoutId;
  final String scoutName;
  final DateTime createdAt;
  final String description;
  final List<String> imageUrls;
  final String status; // draft, submitted, approved, rejected

  const ScoutReport({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.playerPosition,
    required this.playerAge,
    required this.playerTeam,
    required this.matchDate,
    required this.rivalTeam,
    required this.score,
    required this.minutePlayed,
    required this.matchType,
    required this.physicalRating,
    required this.physicalDescription,
    required this.technicalRating,
    required this.technicalDescription,
    required this.tacticalRating,
    required this.tacticalDescription,
    required this.mentalRating,
    required this.mentalDescription,
    required this.overallRating,
    required this.potentialRating,
    required this.strengths,
    required this.weaknesses,
    required this.risks,
    required this.recommendedRole,
    required this.scoutId,
    required this.scoutName,
    required this.createdAt,
    required this.description,
    required this.imageUrls,
    this.status = 'submitted',
  });

  ScoutReport copyWith({
    String? id,
    String? playerId,
    String? playerName,
    String? playerPosition,
    int? playerAge,
    String? playerTeam,
    DateTime? matchDate,
    String? rivalTeam,
    String? score,
    int? minutePlayed,
    String? matchType,
    int? physicalRating,
    String? physicalDescription,
    int? technicalRating,
    String? technicalDescription,
    int? tacticalRating,
    String? tacticalDescription,
    int? mentalRating,
    String? mentalDescription,
    double? overallRating,
    double? potentialRating,
    String? strengths,
    String? weaknesses,
    String? risks,
    String? recommendedRole,
    String? scoutId,
    String? scoutName,
    DateTime? createdAt,
    String? description,
    List<String>? imageUrls,
    String? status,
  }) {
    return ScoutReport(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      playerPosition: playerPosition ?? this.playerPosition,
      playerAge: playerAge ?? this.playerAge,
      playerTeam: playerTeam ?? this.playerTeam,
      matchDate: matchDate ?? this.matchDate,
      rivalTeam: rivalTeam ?? this.rivalTeam,
      score: score ?? this.score,
      minutePlayed: minutePlayed ?? this.minutePlayed,
      matchType: matchType ?? this.matchType,
      physicalRating: physicalRating ?? this.physicalRating,
      physicalDescription: physicalDescription ?? this.physicalDescription,
      technicalRating: technicalRating ?? this.technicalRating,
      technicalDescription: technicalDescription ?? this.technicalDescription,
      tacticalRating: tacticalRating ?? this.tacticalRating,
      tacticalDescription: tacticalDescription ?? this.tacticalDescription,
      mentalRating: mentalRating ?? this.mentalRating,
      mentalDescription: mentalDescription ?? this.mentalDescription,
      overallRating: overallRating ?? this.overallRating,
      potentialRating: potentialRating ?? this.potentialRating,
      strengths: strengths ?? this.strengths,
      weaknesses: weaknesses ?? this.weaknesses,
      risks: risks ?? this.risks,
      recommendedRole: recommendedRole ?? this.recommendedRole,
      scoutId: scoutId ?? this.scoutId,
      scoutName: scoutName ?? this.scoutName,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
    );
  }
}
