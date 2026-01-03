import 'api_client.dart';
import '../../models/dashboard_stats.dart';

/// Dashboard API service for Club Panel
class DashboardApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Get dashboard statistics
  Future<DashboardStats> getStats() async {
    final response = await _client.get('/dashboard/stats');
    return _parseStats(response.data);
  }
  
  /// Get full dashboard data
  Future<DashboardResponse> getDashboard() async {
    final response = await _client.get('/dashboard');
    return DashboardResponse.fromJson(response.data);
  }
  
  DashboardStats _parseStats(Map<String, dynamic> json) {
    final weeklyActivity = (json['weekly_activity'] as List<dynamic>?)
        ?.map((e) => (e['reports'] as int?) ?? 0)
        .toList() ?? [0, 0, 0, 0, 0, 0, 0];
    
    return DashboardStats(
      totalPlayers: json['total_reports'] as int? ?? 0,
      activeScouts: json['scouts_count'] as int? ?? 0,
      pendingReports: json['pending_reports'] as int? ?? 0,
      approvedTransfers: json['approved_reports'] as int? ?? 0,
      onlineScouts: json['online_users'] as int? ?? 0,
      weeklyActivity: weeklyActivity,
      apiResponseMs: json['api_response_ms'] as int? ?? 0,
      dbStatus: json['db_status'] as bool? ?? true,
    );
  }
}

/// Full dashboard response
class DashboardResponse {
  final DashboardStats stats;
  final List<RecentActivity> recentActivities;
  final List<PendingItem> pendingItems;
  
  DashboardResponse({
    required this.stats,
    required this.recentActivities,
    required this.pendingItems,
  });
  
  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    final weeklyActivity = (json['stats']['weekly_activity'] as List<dynamic>?)
        ?.map((e) => (e['reports'] as int?) ?? 0)
        .toList() ?? [0, 0, 0, 0, 0, 0, 0];
    
    return DashboardResponse(
      stats: DashboardStats(
        totalPlayers: json['stats']['total_reports'] as int? ?? 0,
        activeScouts: json['stats']['scouts_count'] as int? ?? 0,
        pendingReports: json['stats']['pending_reports'] as int? ?? 0,
        approvedTransfers: json['stats']['approved_reports'] as int? ?? 0,
        onlineScouts: json['stats']['online_users'] as int? ?? 0,
        weeklyActivity: weeklyActivity,
        apiResponseMs: json['stats']['api_response_ms'] as int? ?? 0,
        dbStatus: json['stats']['db_status'] as bool? ?? true,
      ),
      recentActivities: (json['recent_activities'] as List<dynamic>?)
          ?.map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      pendingItems: (json['pending_items'] as List<dynamic>?)
          ?.map((e) => PendingItem.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

/// Recent activity item
class RecentActivity {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? userName;
  final String? userAvatar;
  
  RecentActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.userName,
    this.userAvatar,
  });
  
  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userName: json['user_name'] as String?,
      userAvatar: json['user_avatar'] as String?,
    );
  }
}

/// Pending item
class PendingItem {
  final String id;
  final String type;
  final String title;
  final String subtitle;
  final DateTime createdAt;
  final String authorName;
  final String? authorAvatar;
  
  PendingItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.authorName,
    this.authorAvatar,
  });
  
  factory PendingItem.fromJson(Map<String, dynamic> json) {
    return PendingItem(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      authorName: json['author_name'] as String,
      authorAvatar: json['author_avatar'] as String?,
    );
  }
}
