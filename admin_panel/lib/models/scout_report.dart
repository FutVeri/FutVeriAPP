/// Scout Report model - copied from mobile app
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

  // Ratings (Map of parameter name to score 1-10)
  final Map<String, int> ratings;

  // Analysis
  final String physicalAttributes;
  final String technicalAttributes;
  final String tacticalAttributes;
  final String mentalAttributes;

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
    required this.ratings,
    required this.physicalAttributes,
    required this.technicalAttributes,
    required this.tacticalAttributes,
    required this.mentalAttributes,
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
    Map<String, int>? ratings,
    String? physicalAttributes,
    String? technicalAttributes,
    String? tacticalAttributes,
    String? mentalAttributes,
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
      ratings: ratings ?? this.ratings,
      physicalAttributes: physicalAttributes ?? this.physicalAttributes,
      technicalAttributes: technicalAttributes ?? this.technicalAttributes,
      tacticalAttributes: tacticalAttributes ?? this.tacticalAttributes,
      mentalAttributes: mentalAttributes ?? this.mentalAttributes,
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

  // Overall rating calculated from all ratings
  double get overallRating {
    if (ratings.isEmpty) return 0;
    return ratings.values.reduce((a, b) => a + b) / ratings.length;
  }
}
