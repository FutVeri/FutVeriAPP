import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:futveri/core/supabase/supabase_client.dart';

// State for Scout Reports List
class ScoutReportsState {
  final List<ScoutReport> reports;
  final bool isLoading;
  final String? errorMessage;

  ScoutReportsState({
    this.reports = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ScoutReportsState copyWith({
    List<ScoutReport>? reports,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ScoutReportsState(
      reports: reports ?? this.reports,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class ScoutReportsViewModel extends Notifier<ScoutReportsState> {
  @override
  ScoutReportsState build() {
    // Load reports on init
    Future.microtask(() => loadReports());
    return ScoutReportsState(isLoading: true);
  }

  /// Load reports from Supabase
  Future<void> loadReports() async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      print('📋 Loading reports for user ${user.id} from Supabase...');
      final response = await supabase.client
          .from('scout_reports')
          .select()
          .eq('scout_id', user.id)
          .order('created_at', ascending: false);
      
      print('📋 Got ${response.length} reports');
      
      final reports = (response as List).map((data) {
        return ScoutReport.fromJson(data as Map<String, dynamic>);
      }).toList();
      
      state = state.copyWith(reports: reports, isLoading: false);
      print('✅ Reports loaded successfully');
    } catch (e) {
      print('❌ Error loading reports: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Raporlar yüklenemedi: $e',
      );
    }
  }

  /// Refresh reports
  Future<void> refresh() => loadReports();

  /// Delete report
  Future<bool> deleteReport(String id) async {
    try {
      print('🗑️ Deleting report: $id');
      await supabase.client.from('scout_reports').delete().eq('id', id);
      await loadReports(); // Refresh list
      return true;
    } catch (e) {
      print('❌ Error deleting report: $e');
      return false;
    }
  }
}

final scoutReportsProvider = NotifierProvider<ScoutReportsViewModel, ScoutReportsState>(() {
  return ScoutReportsViewModel();
});

final reportByIdProvider = FutureProvider.family<ScoutReport?, String>((ref, id) async {
  try {
    print('🔍 Fetching report by ID: $id');
    final response = await supabase.client
        .from('scout_reports')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) {
      print('⚠️ Report not found for ID: $id');
      return null;
    }

    print('✅ Report found: ${response['player_name']}');
    return ScoutReport.fromJson(response as Map<String, dynamic>);
  } catch (e) {
    print('❌ Error fetching report by ID ($id): $e');
    return null;
  }
});
