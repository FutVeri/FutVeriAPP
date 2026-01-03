import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api.dart';
import '../domain/scout_report.dart';

/// Scout report list state
class ReportsState {
  final List<ScoutReport> reports;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;

  const ReportsState({
    this.reports = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.errorMessage,
  });

  ReportsState copyWith({
    List<ScoutReport>? reports,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
  }) {
    return ReportsState(
      reports: reports ?? this.reports,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

/// Scout reports repository
class ReportsRepository {
  final Dio _dio;

  ReportsRepository(this._dio);

  /// Get reports list with pagination
  Future<({List<ScoutReport> items, int total, int pages})> getReports({
    int page = 1,
    int size = 20,
    String? status,
    String? playerName,
    bool myReports = false,
  }) async {
    try {
      final response = await _dio.get(
        ApiConfig.reports,
        queryParameters: {
          'page': page,
          'size': size,
          if (status != null) 'status': status,
          if (playerName != null) 'player_name': playerName,
          if (myReports) 'my_reports': true,
        },
      );

      final data = response.data;
      final items = (data['items'] as List)
          .map((json) => ScoutReport.fromJson(json))
          .toList();

      return (
        items: items,
        total: data['total'] as int,
        pages: data['pages'] as int,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Get single report by ID
  Future<ScoutReport> getReport(String id) async {
    try {
      final response = await _dio.get('${ApiConfig.reports}/$id');
      return ScoutReport.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Create new report
  Future<ScoutReport> createReport(ScoutReport report) async {
    try {
      final response = await _dio.post(
        ApiConfig.reports,
        data: report.toJson(),
      );
      return ScoutReport.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Update existing report
  Future<ScoutReport> updateReport(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.reports}/$id',
        data: data,
      );
      return ScoutReport.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Delete report
  Future<void> deleteReport(String id) async {
    try {
      await _dio.delete('${ApiConfig.reports}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Submit report for approval
  Future<void> submitReport(String id) async {
    try {
      await _dio.post('${ApiConfig.reports}/$id/submit');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

/// Reports repository provider
final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  final dio = ref.read(dioProvider);
  return ReportsRepository(dio);
});

/// Reports list notifier - using Notifier for Riverpod 3.x
class ReportsNotifier extends Notifier<ReportsState> {
  late final ReportsRepository _repository;

  @override
  ReportsState build() {
    _repository = ref.read(reportsRepositoryProvider);
    return const ReportsState();
  }

  Future<void> loadReports({bool refresh = false}) async {
    if (state.isLoading) return;
    if (!refresh && !state.hasMore) return;

    final page = refresh ? 1 : state.currentPage + 1;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await _repository.getReports(page: page);

      final newReports = refresh
          ? result.items
          : [...state.reports, ...result.items];

      state = state.copyWith(
        reports: newReports,
        isLoading: false,
        hasMore: page < result.pages,
        currentPage: page,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    }
  }

  Future<void> refresh() => loadReports(refresh: true);

  void removeReport(String id) {
    state = state.copyWith(
      reports: state.reports.where((r) => r.id != id).toList(),
    );
  }
}

/// Reports provider
final reportsProvider = NotifierProvider<ReportsNotifier, ReportsState>(
  ReportsNotifier.new,
);

/// My reports provider (filtered to current user)
final myReportsProvider = NotifierProvider<ReportsNotifier, ReportsState>(
  ReportsNotifier.new,
);
