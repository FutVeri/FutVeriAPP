// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoutReport _$ScoutReportFromJson(Map<String, dynamic> json) => _ScoutReport(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  playerName: json['playerName'] as String,
  playerPosition: json['playerPosition'] as String,
  playerAge: (json['playerAge'] as num).toInt(),
  playerTeam: json['playerTeam'] as String,
  matchDate: DateTime.parse(json['matchDate'] as String),
  rivalTeam: json['rivalTeam'] as String,
  score: json['score'] as String,
  minutePlayed: (json['minutePlayed'] as num).toInt(),
  matchType: json['matchType'] as String,
  physicalRating: (json['physicalRating'] as num).toInt(),
  physicalDescription: json['physicalDescription'] as String,
  technicalRating: (json['technicalRating'] as num).toInt(),
  technicalDescription: json['technicalDescription'] as String,
  tacticalRating: (json['tacticalRating'] as num).toInt(),
  tacticalDescription: json['tacticalDescription'] as String,
  mentalRating: (json['mentalRating'] as num).toInt(),
  mentalDescription: json['mentalDescription'] as String,
  overallRating: (json['overallRating'] as num).toDouble(),
  potentialRating: (json['potentialRating'] as num).toDouble(),
  strengths: json['strengths'] as String,
  weaknesses: json['weaknesses'] as String,
  risks: json['risks'] as String,
  recommendedRole: json['recommendedRole'] as String,
  scoutId: json['scoutId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String,
  imageUrls: (json['imageUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  status: json['status'] as String? ?? 'draft',
);

Map<String, dynamic> _$ScoutReportToJson(_ScoutReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerPosition': instance.playerPosition,
      'playerAge': instance.playerAge,
      'playerTeam': instance.playerTeam,
      'matchDate': instance.matchDate.toIso8601String(),
      'rivalTeam': instance.rivalTeam,
      'score': instance.score,
      'minutePlayed': instance.minutePlayed,
      'matchType': instance.matchType,
      'physicalRating': instance.physicalRating,
      'physicalDescription': instance.physicalDescription,
      'technicalRating': instance.technicalRating,
      'technicalDescription': instance.technicalDescription,
      'tacticalRating': instance.tacticalRating,
      'tacticalDescription': instance.tacticalDescription,
      'mentalRating': instance.mentalRating,
      'mentalDescription': instance.mentalDescription,
      'overallRating': instance.overallRating,
      'potentialRating': instance.potentialRating,
      'strengths': instance.strengths,
      'weaknesses': instance.weaknesses,
      'risks': instance.risks,
      'recommendedRole': instance.recommendedRole,
      'scoutId': instance.scoutId,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'imageUrls': instance.imageUrls,
      'status': instance.status,
    };
