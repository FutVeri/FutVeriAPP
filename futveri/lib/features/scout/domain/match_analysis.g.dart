// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchAnalysis _$MatchAnalysisFromJson(Map<String, dynamic> json) =>
    _MatchAnalysis(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      homeTeam: json['home_team'] as String,
      awayTeam: json['away_team'] as String,
      scorePrediction: json['score_prediction'] as String,
      analysisContent: json['analysis_content'] as String,
      matchDate: DateTime.parse(json['match_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MatchAnalysisToJson(_MatchAnalysis instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'home_team': instance.homeTeam,
      'away_team': instance.awayTeam,
      'score_prediction': instance.scorePrediction,
      'analysis_content': instance.analysisContent,
      'match_date': instance.matchDate.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
