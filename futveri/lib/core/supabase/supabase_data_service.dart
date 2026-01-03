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
}

/// Global data service instance
final supabaseData = SupabaseDataService.instance;
