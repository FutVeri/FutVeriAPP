import 'api_client.dart';
import '../../features/scout/domain/scout_report.dart';

/// Scout Reports API service
class ReportsApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Get paginated list of reports
  Future<ReportsListResponse> getReports({
    int page = 1,
    int size = 20,
    String? status,
    String? scoutId,
  }) async {
    final response = await _client.get(
      '/reports',
      queryParameters: {
        'page': page,
        'size': size,
        if (status != null) 'status': status,
        if (scoutId != null) 'scout_id': scoutId,
      },
    );
    
    return ReportsListResponse.fromJson(response.data);
  }
  
  /// Get single report by ID
  Future<ScoutReport> getReport(String id) async {
    final response = await _client.get('/reports/$id');
    return _parseReportFromApi(response.data);
  }
  
  /// Create a new report
  Future<ScoutReport> createReport(ScoutReport report) async {
    final response = await _client.post(
      '/reports',
      data: _reportToApiJson(report),
    );
    return _parseReportFromApi(response.data);
  }
  
  /// Update an existing report
  Future<ScoutReport> updateReport(String id, ScoutReport report) async {
    final response = await _client.put(
      '/reports/$id',
      data: _reportToApiJson(report),
    );
    return _parseReportFromApi(response.data);
  }
  
  /// Submit a draft report for review
  Future<ScoutReport> submitReport(String id) async {
    final response = await _client.post('/reports/$id/submit');
    return _parseReportFromApi(response.data);
  }
  
  /// Delete a report
  Future<void> deleteReport(String id) async {
    await _client.delete('/reports/$id');
  }
  
  /// Convert API response to ScoutReport model
  ScoutReport _parseReportFromApi(Map<String, dynamic> json) {
    return ScoutReport(
      id: json['id'] as String,
      playerId: json['player_id'] as String? ?? '',
      playerName: json['player_name'] as String,
      playerPosition: json['player_position'] as String,
      playerAge: json['player_age'] as int,
      playerTeam: json['player_team'] as String,
      matchDate: DateTime.parse(json['match_date'] as String),
      rivalTeam: json['rival_team'] as String,
      score: json['score'] as String,
      minutePlayed: json['minute_played'] as int,
      matchType: json['match_type'] as String,
      physicalRating: json['physical_rating'] as int,
      physicalDescription: json['physical_description'] as String,
      technicalRating: json['technical_rating'] as int,
      technicalDescription: json['technical_description'] as String,
      tacticalRating: json['tactical_rating'] as int,
      tacticalDescription: json['tactical_description'] as String,
      mentalRating: json['mental_rating'] as int,
      mentalDescription: json['mental_description'] as String,
      overallRating: (json['overall_rating'] as num).toDouble(),
      potentialRating: (json['potential_rating'] as num).toDouble(),
      strengths: json['strengths'] as String,
      weaknesses: json['weaknesses'] as String,
      risks: json['risks'] as String,
      recommendedRole: json['recommended_role'] as String,
      scoutId: json['scout_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      description: json['description'] as String? ?? '',
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      status: json['status'] as String? ?? 'draft',
    );
  }
  
  /// Convert ScoutReport to API request format
  Map<String, dynamic> _reportToApiJson(ScoutReport report) {
    return {
      if (report.playerId.isNotEmpty) 'player_id': report.playerId,
      'player_name': report.playerName,
      'player_position': report.playerPosition,
      'player_age': report.playerAge,
      'player_team': report.playerTeam,
      'match_date': report.matchDate.toIso8601String(),
      'rival_team': report.rivalTeam,
      'score': report.score,
      'minute_played': report.minutePlayed,
      'match_type': report.matchType,
      'physical_rating': report.physicalRating,
      'physical_description': report.physicalDescription,
      'technical_rating': report.technicalRating,
      'technical_description': report.technicalDescription,
      'tactical_rating': report.tacticalRating,
      'tactical_description': report.tacticalDescription,
      'mental_rating': report.mentalRating,
      'mental_description': report.mentalDescription,
      'overall_rating': report.overallRating,
      'potential_rating': report.potentialRating,
      'strengths': report.strengths,
      'weaknesses': report.weaknesses,
      'risks': report.risks,
      'recommended_role': report.recommendedRole,
      'description': report.description,
      'notes': report.description,
      'image_urls': report.imageUrls,
      'status': report.status,
    };
  }
}

/// Paginated reports list response
class ReportsListResponse {
  final List<ScoutReport> items;
  final int total;
  final int page;
  final int size;
  final int pages;
  
  ReportsListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });
  
  factory ReportsListResponse.fromJson(Map<String, dynamic> json) {
    final reportsApi = ReportsApi();
    return ReportsListResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => reportsApi._parseReportFromApi(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      pages: json['pages'] as int,
    );
  }
}
