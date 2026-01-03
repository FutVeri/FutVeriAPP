// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoutReport _$ScoutReportFromJson(Map<String, dynamic> json) => _ScoutReport(
  id: json['id'] as String,
  playerId: json['player_id'] as String?,
  playerName: json['player_name'] as String,
  playerPosition: json['player_position'] as String,
  playerAge: (json['player_age'] as num).toInt(),
  playerTeam: json['player_team'] as String,
  matchDate: DateTime.parse(json['match_date'] as String),
  rivalTeam: json['rival_team'] as String,
  score: json['score'] as String,
  minutePlayed: (json['minute_played'] as num).toInt(),
  matchType: json['match_type'] as String,
  physicalRating: (json['physical_rating'] as num).toInt(),
  physicalDescription: json['physical_description'] as String,
  technicalRating: (json['technical_rating'] as num).toInt(),
  technicalDescription: json['technical_description'] as String,
  tacticalRating: (json['tactical_rating'] as num).toInt(),
  tacticalDescription: json['tactical_description'] as String,
  mentalRating: (json['mental_rating'] as num).toInt(),
  mentalDescription: json['mental_description'] as String,
  overallRating: (json['overall_rating'] as num).toDouble(),
  potentialRating: (json['potential_rating'] as num).toDouble(),
  strengths: json['strengths'] as String,
  weaknesses: json['weaknesses'] as String,
  risks: json['risks'] as String,
  recommendedRole: json['recommended_role'] as String,
  scoutId: json['scout_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  description: json['description'] as String?,
  imageUrls:
      (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  status: json['status'] as String? ?? 'draft',
);

Map<String, dynamic> _$ScoutReportToJson(_ScoutReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player_id': instance.playerId,
      'player_name': instance.playerName,
      'player_position': instance.playerPosition,
      'player_age': instance.playerAge,
      'player_team': instance.playerTeam,
      'match_date': instance.matchDate.toIso8601String(),
      'rival_team': instance.rivalTeam,
      'score': instance.score,
      'minute_played': instance.minutePlayed,
      'match_type': instance.matchType,
      'physical_rating': instance.physicalRating,
      'physical_description': instance.physicalDescription,
      'technical_rating': instance.technicalRating,
      'technical_description': instance.technicalDescription,
      'tactical_rating': instance.tacticalRating,
      'tactical_description': instance.tacticalDescription,
      'mental_rating': instance.mentalRating,
      'mental_description': instance.mentalDescription,
      'overall_rating': instance.overallRating,
      'potential_rating': instance.potentialRating,
      'strengths': instance.strengths,
      'weaknesses': instance.weaknesses,
      'risks': instance.risks,
      'recommended_role': instance.recommendedRole,
      'scout_id': instance.scoutId,
      'created_at': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'image_urls': instance.imageUrls,
      'status': instance.status,
    };
