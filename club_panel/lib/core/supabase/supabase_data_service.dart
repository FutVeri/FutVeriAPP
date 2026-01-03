import 'supabase_client.dart';
import '../../models/club.dart';
import '../../models/scout_report.dart';
import '../../models/dashboard_stats.dart';

/// Supabase Data Service for Club Panel database operations
class SupabaseDataService {
  SupabaseDataService._();
  static final SupabaseDataService _instance = SupabaseDataService._();
  static SupabaseDataService get instance => _instance;
  
  /// Get club's players
  Future<List<Player>> getPlayers({
    int limit = 50,
    int offset = 0,
    String? position,
  }) async {
    var query = supabase.client
        .from('players')
        .select();
    
    if (position != null) {
      query = query.eq('position', position);
    }
    
    final response = await query
        .range(offset, offset + limit - 1)
        .order('name');
    
    return List<Map<String, dynamic>>.from(response).map((json) {
      return Player(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrl: json['image_url'] as String?,
        age: json['age'] as int? ?? 0,
        position: json['position'] as String? ?? 'Unknown',
        currentClub: json['current_club'] as String? ?? 'Unknown',
        nationality: json['nationality'] as String? ?? 'Unknown',
        marketValue: (json['market_value'] as num?)?.toDouble(),
        reportsCount: json['reports_count'] as int? ?? 0,
        averageRating: (json['average_rating'] as num?)?.toDouble(),
      );
    }).toList();
  }
  
  /// Get scouts assigned to club
  Future<List<Scout>> getScouts({
    String? clubId,
    bool? isActive,
  }) async {
    var query = supabase.client
        .from('users')
        .select()
        .eq('role', 'scout');
    
    if (isActive != null) {
      query = query.eq('is_active', isActive);
    }
    
    final response = await query.order('name');
    
    return List<Map<String, dynamic>>.from(response).map((json) {
      return Scout(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        avatarUrl: json['avatar_url'] as String?,
        region: json['region'] as String? ?? 'Unknown',
        totalReports: json['total_reports'] as int? ?? 0,
        activeAssignments: json['active_assignments'] as int? ?? 0,
        joinedAt: DateTime.parse(json['created_at'] as String),
        isActive: json['is_active'] as bool? ?? true,
      );
    }).toList();
  }
  
  /// Get scout reports for club
  Future<List<ScoutReport>> getReports({
    String? clubId,
    String? playerId,
    int limit = 50,
    int offset = 0,
  }) async {
    var query = supabase.client
        .from('scout_reports')
        .select('*, players(name, position, current_club), users!scout_id(name, avatar_url)');
    
    if (clubId != null) {
      query = query.eq('club_id', clubId);
    }
    
    if (playerId != null) {
      query = query.eq('player_id', playerId);
    }
    
    final response = await query
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response).map((json) {
      final player = json['players'] as Map<String, dynamic>?;
      final scout = json['users'] as Map<String, dynamic>?;
      
      return ScoutReport(
        id: json['id'] as String,
        playerId: json['player_id'] as String,
        playerName: player?['name'] as String? ?? 'Unknown',
        playerPosition: player?['position'] as String? ?? 'Unknown',
        playerClub: player?['current_club'] as String? ?? 'Unknown',
        scoutId: json['scout_id'] as String,
        scoutName: scout?['name'] as String? ?? 'Unknown',
        scoutAvatarUrl: scout?['avatar_url'] as String?,
        matchDate: DateTime.parse(json['match_date'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
        physicalRating: (json['physical_rating'] as num?)?.toDouble() ?? 0,
        physicalDescription: json['physical_description'] as String?,
        technicalRating: (json['technical_rating'] as num?)?.toDouble() ?? 0,
        technicalDescription: json['technical_description'] as String?,
        tacticalRating: (json['tactical_rating'] as num?)?.toDouble() ?? 0,
        tacticalDescription: json['tactical_description'] as String?,
        mentalRating: (json['mental_rating'] as num?)?.toDouble() ?? 0,
        mentalDescription: json['mental_description'] as String?,
        overallRating: (json['overall_rating'] as num?)?.toDouble() ?? 0,
        overallDescription: json['overall_description'] as String?,
        potentialRating: (json['potential_rating'] as num?)?.toDouble() ?? 0,
        potentialDescription: json['potential_description'] as String?,
      );
    }).toList();
  }
  
  /// Get dashboard statistics
  Future<DashboardStats> getDashboardStats(String clubId) async {
    try {
      // Get total players followed
      final playersCount = await supabase.client
          .from('players')
          .select()
          .count();
      
      // Get total reports
      final reportsCount = await supabase.client
          .from('scout_reports')
          .select()
          .eq('club_id', clubId)
          .count();
      
      // Get active scouts count
      final scoutsCount = await supabase.client
          .from('users')
          .select()
          .eq('role', 'scout')
          .eq('is_active', true)
          .count();
      
      // Get this month's reports
      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final monthlyReportsCount = await supabase.client
          .from('scout_reports')
          .select()
          .eq('club_id', clubId)
          .gte('created_at', monthStart.toIso8601String())
          .count();
      
      return DashboardStats(
        totalPlayers: playersCount.count,
        totalReports: reportsCount.count,
        activeScouts: scoutsCount.count,
        monthlyReports: monthlyReportsCount.count,
      );
    } catch (e) {
      return const DashboardStats(
        totalPlayers: 0,
        totalReports: 0,
        activeScouts: 0,
        monthlyReports: 0,
      );
    }
  }
}

/// Global data service instance
final supabaseData = SupabaseDataService.instance;
