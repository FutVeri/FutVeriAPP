import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_analysis.freezed.dart';
part 'match_analysis.g.dart';

@freezed
class MatchAnalysis with _$MatchAnalysis {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MatchAnalysis({
    required String id,
    required String userId,
    required String homeTeam,
    required String awayTeam,
    required String scorePrediction,
    required String analysisContent,
    required DateTime matchDate,
    required DateTime createdAt,
  }) = _MatchAnalysis;

  factory MatchAnalysis.fromJson(Map<String, dynamic> json) => _$MatchAnalysisFromJson(json);
}
