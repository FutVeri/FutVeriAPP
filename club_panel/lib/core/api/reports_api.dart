import 'api_client.dart';
import '../../models/scout_report.dart';

/// Reports API service for Club Panel
class ReportsApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Get paginated list of reports
  Future<ReportsListResponse> getReports({
    int page = 1,
    int size = 20,
    String? status,
  }) async {
    final response = await _client.get(
      '/reports',
      queryParameters: {
        'page': page,
        'size': size,
        if (status != null) 'status': status,
      },
    );
    
    return ReportsListResponse.fromJson(response.data);
  }
  
  /// Get single report by ID
  Future<ScoutReport> getReport(String id) async {
    final response = await _client.get('/reports/$id');
    return _parseReportFromApi(response.data);
  }
  
  /// Convert API response to ScoutReport model
  ScoutReport _parseReportFromApi(Map<String, dynamic> json) {
    return ScoutReport(
      id: json['id'] as String,
      playerName: json['player_name'] as String,
      playerImage: json['player_image_url'] as String?,
      scoutName: json['scout_name'] as String? ?? 'Unknown Scout',
      scoutId: json['scout_id'] as String,
      playerAge: json['player_age'] as int,
      position: json['player_position'] as String,
      currentClub: json['player_team'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: _parseStatus(json['status'] as String),
      physical: RatingDetails(
        value: json['physical_rating'] as int,
        description: json['physical_description'] as String,
      ),
      technical: RatingDetails(
        value: json['technical_rating'] as int,
        description: json['technical_description'] as String,
      ),
      tactical: RatingDetails(
        value: json['tactical_rating'] as int,
        description: json['tactical_description'] as String,
      ),
      mental: RatingDetails(
        value: json['mental_rating'] as int,
        description: json['mental_description'] as String,
      ),
      overall: RatingDetails(
        value: (json['overall_rating'] as num).toInt(),
        description: json['strengths'] as String? ?? '',
      ),
      potential: RatingDetails(
        value: (json['potential_rating'] as num).toInt(),
        description: json['recommended_role'] as String? ?? '',
      ),
      notes: json['notes'] as String?,
    );
  }
  
  ReportStatus _parseStatus(String status) {
    switch (status) {
      case 'approved':
        return ReportStatus.approved;
      case 'rejected':
        return ReportStatus.rejected;
      case 'pending':
      case 'submitted':
      default:
        return ReportStatus.pending;
    }
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
