import 'supabase_client.dart';

/// Supabase Data Service for database operations
class SupabaseDataService {
  SupabaseDataService._();
  static final SupabaseDataService _instance = SupabaseDataService._();
  static SupabaseDataService get instance => _instance;
  
  /// Get all players
  Future<List<Map<String, dynamic>>> getPlayers({
    int limit = 50,
    int offset = 0,
    String? position,
    String? nationality,
  }) async {
    var query = supabase.client
        .from('players')
        .select();
    
    if (position != null) {
      query = query.eq('position', position);
    }
    
    if (nationality != null) {
      query = query.eq('nationality', nationality);
    }
    
    final response = await query
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }
  
  /// Get player by ID
  Future<Map<String, dynamic>?> getPlayer(String playerId) async {
    final response = await supabase.client
        .from('players')
        .select()
        .eq('id', playerId)
        .maybeSingle();
    
    return response;
  }
  
  /// Get scout reports
  Future<List<Map<String, dynamic>>> getReports({
    int limit = 50,
    int offset = 0,
    String? playerId,
    String? scoutId,
    String? clubId,
  }) async {
    var query = supabase.client
        .from('scout_reports')
        .select('*, players(*), users!scout_id(*)');
    
    if (playerId != null) {
      query = query.eq('player_id', playerId);
    }
    
    if (scoutId != null) {
      query = query.eq('scout_id', scoutId);
    }
    
    if (clubId != null) {
      query = query.eq('club_id', clubId);
    }
    
    final response = await query
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }
  
  /// Get report by ID
  Future<Map<String, dynamic>?> getReport(String reportId) async {
    final response = await supabase.client
        .from('scout_reports')
        .select('*, players(*), users!scout_id(*)')
        .eq('id', reportId)
        .maybeSingle();
    
    return response;
  }
  
  /// Create a new report
  Future<Map<String, dynamic>?> createReport(Map<String, dynamic> report) async {
    final response = await supabase.client
        .from('scout_reports')
        .insert(report)
        .select()
        .single();
    
    return response;
  }
  
  /// Update a report
  Future<Map<String, dynamic>?> updateReport(String reportId, Map<String, dynamic> updates) async {
    final response = await supabase.client
        .from('scout_reports')
        .update(updates)
        .eq('id', reportId)
        .select()
        .single();
    
    return response;
  }
  
  /// Delete a report
  Future<void> deleteReport(String reportId) async {
    await supabase.client
        .from('scout_reports')
        .delete()
        .eq('id', reportId);
  }
  
  /// Get scouts
  Future<List<Map<String, dynamic>>> getScouts({
    int limit = 50,
    int offset = 0,
    bool? isActive,
  }) async {
    var query = supabase.client
        .from('users')
        .select()
        .eq('role', 'scout');
    
    if (isActive != null) {
      query = query.eq('is_active', isActive);
    }
    
    final response = await query
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }
  
  /// Get dashboard statistics
  Future<Map<String, dynamic>> getDashboardStats(String clubId) async {
    try {
      // Get total players count
      final playersCount = await supabase.client
          .from('players')
          .select()
          .count();
      
      // Get total reports count
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
      
      // Get recent reports
      final recentReports = await supabase.client
          .from('scout_reports')
          .select('*, players(*)')
          .eq('club_id', clubId)
          .order('created_at', ascending: false)
          .limit(5);
      
      return {
        'total_players': playersCount.count,
        'total_reports': reportsCount.count,
        'active_scouts': scoutsCount.count,
        'recent_reports': recentReports,
      };
    } catch (e) {
      return {
        'total_players': 0,
        'total_reports': 0,
        'active_scouts': 0,
        'recent_reports': [],
      };
    }
  }
  
  // ============================================================
  // LEAGUE SYSTEM - Future Supabase Integration
  // Uncomment these methods when ready to connect to Supabase
  // ============================================================
  
  // /// Get league members for current month
  // /// Table: league_members (id, user_id, league_id, points, report_count, rank)
  // Future<List<Map<String, dynamic>>> getLeagueMembers({
  //   required String leagueId,
  //   int limit = 30,
  // }) async {
  //   final response = await supabase.client
  //       .from('league_members')
  //       .select('*, users(*)')
  //       .eq('league_id', leagueId)
  //       .order('points', ascending: false)
  //       .limit(limit);
  //   
  //   return List<Map<String, dynamic>>.from(response);
  // }
  
  // /// Get user's earned badges
  // /// Table: league_badges (id, user_id, badge_type, earned_at, league_period)
  // Future<List<Map<String, dynamic>>> getUserBadges(String userId) async {
  //   final response = await supabase.client
  //       .from('league_badges')
  //       .select()
  //       .eq('user_id', userId)
  //       .order('earned_at', ascending: false);
  //   
  //   return List<Map<String, dynamic>>.from(response);
  // }
  
  // /// Award badge to top 3 finishers at end of month
  // /// badgeType: 'gold', 'silver', 'bronze'
  // Future<void> awardBadge({
  //   required String userId,
  //   required String badgeType,
  //   required String leaguePeriod,
  // }) async {
  //   await supabase.client.from('league_badges').insert({
  //     'user_id': userId,
  //     'badge_type': badgeType,
  //     'league_period': leaguePeriod,
  //     'earned_at': DateTime.now().toIso8601String(),
  //   });
  // }
  
  // /// Get current active league
  // /// Table: leagues (id, name, period, start_date, end_date)
  // Future<Map<String, dynamic>?> getCurrentLeague() async {
  //   final now = DateTime.now().toIso8601String();
  //   final response = await supabase.client
  //       .from('leagues')
  //       .select()
  //       .lte('start_date', now)
  //       .gte('end_date', now)
  //       .maybeSingle();
  //   
  //   return response;
  // }
  
  // /// Update user's league points (called after report submission)
  // Future<void> updateLeaguePoints({
  //   required String userId,
  //   required String leagueId,
  //   required int pointsToAdd,
  // }) async {
  //   // Get current points
  //   final current = await supabase.client
  //       .from('league_members')
  //       .select('points')
  //       .eq('user_id', userId)
  //       .eq('league_id', leagueId)
  //       .maybeSingle();
  //   
  //   final currentPoints = (current?['points'] ?? 0) as int;
  //   
  //   await supabase.client.from('league_members').upsert({
  //     'user_id': userId,
  //     'league_id': leagueId,
  //     'points': currentPoints + pointsToAdd,
  //   });
  // }
}

/// Global data service instance
final supabaseData = SupabaseDataService.instance;

