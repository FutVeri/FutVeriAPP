import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/scout_report.dart';
import '../models/user.dart';
import '../models/dashboard_stats.dart';

/// Supabase client instance
final supabase = Supabase.instance.client;

/// Supabase Data Service Provider
final supabaseDataServiceProvider = Provider((ref) => SupabaseDataService());

/// Supabase Data Service for fetching live data
class SupabaseDataService {
  
  /// Fetch all scout reports from Supabase
  Future<List<ScoutReport>> getScoutReports() async {
    try {
      final response = await supabase
          .from('scout_reports')
          .select('*, users!scout_reports_scout_id_fkey(name, email)')
          .order('created_at', ascending: false);
      
      return (response as List).map((data) {
        final scoutData = data['users'] as Map<String, dynamic>?;
        return ScoutReport(
          id: data['id'] ?? '',
          playerId: data['player_id'] ?? '',
          playerName: data['player_name'] ?? 'Bilinmeyen',
          playerPosition: data['player_position'] ?? '',
          playerAge: data['player_age'] ?? 0,
          playerTeam: data['player_team'] ?? '',
          matchDate: DateTime.tryParse(data['match_date'] ?? '') ?? DateTime.now(),
          rivalTeam: data['rival_team'] ?? '',
          score: data['match_score'] ?? '',
          minutePlayed: data['minutes_played'] ?? 0,
          matchType: data['watch_type'] ?? '',
          physicalRating: (data['physical_rating'] as num?)?.toInt() ?? 0,
          physicalDescription: data['physical_desc'] ?? '',
          technicalRating: (data['technical_rating'] as num?)?.toInt() ?? 0,
          technicalDescription: data['technical_desc'] ?? '',
          tacticalRating: (data['tactical_rating'] as num?)?.toInt() ?? 0,
          tacticalDescription: data['tactical_desc'] ?? '',
          mentalRating: (data['mental_rating'] as num?)?.toInt() ?? 0,
          mentalDescription: data['mental_desc'] ?? '',
          overallRating: (data['overall_rating'] as num?)?.toDouble() ?? 0.0,
          potentialRating: (data['potential_rating'] as num?)?.toDouble() ?? 0.0,
          strengths: data['strengths'] ?? '',
          weaknesses: data['weaknesses'] ?? '',
          risks: data['risks'] ?? '',
          recommendedRole: data['recommended_role'] ?? '',
          scoutId: data['scout_id'] ?? '',
          scoutName: scoutData?['name'] ?? 'Anonymous Scout',
          createdAt: DateTime.tryParse(data['created_at'] ?? '') ?? DateTime.now(),
          description: data['summary'] ?? '',
          imageUrls: List<String>.from(data['image_urls'] ?? []),
          status: data['status'] ?? 'submitted',
        );
      }).toList();
    } catch (e) {
      print('Error fetching reports: $e');
      return [];
    }
  }

  /// Fetch all users from Supabase
  Future<List<AppUser>> getUsers() async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .order('created_at', ascending: false);
      
      return (response as List).map((data) {
        return AppUser(
          id: data['id'] ?? '',
          name: data['name'] ?? 'Adsız',
          email: data['email'] ?? '',
          role: data['role'] ?? 'user',
          createdAt: DateTime.tryParse(data['created_at'] ?? '') ?? DateTime.now(),
          lastActiveAt: DateTime.tryParse(data['updated_at'] ?? '') ?? DateTime.now(),
          isOnline: false, // Could be determined by updated_at within last 15 mins
          reportCount: 0, // Will be calculated separately if needed
        );
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  /// Fetch dashboard statistics from Supabase
  Future<DashboardStats> getDashboardStats() async {
    try {
      // Fetch users
      final usersResponse = await supabase.from('users').select('id, updated_at');
      final users = usersResponse as List;
      
      // Fetch reports
      final reportsResponse = await supabase.from('scout_reports').select('id, status');
      final reports = reportsResponse as List;
      
      // Fetch posts for activity
      final postsResponse = await supabase.from('posts').select('id');
      final posts = postsResponse as List;
      
      final now = DateTime.now();
      final dailyActiveUsers = users.where((u) {
        final lastActive = DateTime.tryParse(u['updated_at'] ?? '');
        return lastActive != null && now.difference(lastActive).inHours < 24;
      }).length;
      
      final pendingReports = reports.where((r) => r['status'] == 'submitted').length;
      final approvedReports = reports.where((r) => r['status'] == 'approved').length;
      final rejectedReports = reports.where((r) => r['status'] == 'rejected').length;
      
      return DashboardStats(
        totalUsers: users.length,
        dailyActiveUsers: dailyActiveUsers,
        onlineUsers: dailyActiveUsers, // Approximation
        totalReports: reports.length,
        pendingReports: pendingReports,
        approvedReports: approvedReports,
        rejectedReports: rejectedReports,
        apiResponseMs: 50,
        dbStatus: true,
        weeklyActivity: List.generate(7, (i) {
          final date = now.subtract(Duration(days: 6 - i));
          return ActivityPoint(
            date: date,
            users: users.length,
            reports: (reports.length / 7).ceil(),
          );
        }),
      );
    } catch (e) {
      print('Error fetching dashboard stats: $e');
      return DashboardStats(
        totalUsers: 0,
        dailyActiveUsers: 0,
        onlineUsers: 0,
        totalReports: 0,
        pendingReports: 0,
        approvedReports: 0,
        rejectedReports: 0,
        apiResponseMs: 0,
        dbStatus: false,
        weeklyActivity: [],
      );
    }
  }
}
