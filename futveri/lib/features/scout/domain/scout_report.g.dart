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
  ratings: Map<String, int>.from(json['ratings'] as Map),
  physicalAttributes: json['physicalAttributes'] as String,
  technicalAttributes: json['technicalAttributes'] as String,
  tacticalAttributes: json['tacticalAttributes'] as String,
  metalAttributes: json['metalAttributes'] as String,
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
      'ratings': instance.ratings,
      'physicalAttributes': instance.physicalAttributes,
      'technicalAttributes': instance.technicalAttributes,
      'tacticalAttributes': instance.tacticalAttributes,
      'metalAttributes': instance.metalAttributes,
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
