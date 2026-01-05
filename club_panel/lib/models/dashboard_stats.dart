class DashboardStats {
  final int totalPlayers;
  final int activeScouts;
  final int totalReports;
  final int monthlyReports;
  final int pendingReports;
  final int approvedTransfers;
  final int onlineScouts;
  final List<int> weeklyActivity;
  final int apiResponseMs;
  final bool dbStatus;

  const DashboardStats({
    required this.totalPlayers,
    required this.activeScouts,
    required this.totalReports,
    required this.monthlyReports,
    required this.pendingReports,
    required this.approvedTransfers,
    required this.onlineScouts,
    required this.weeklyActivity,
    required this.apiResponseMs,
    required this.dbStatus,
  });

  DashboardStats copyWith({
    int? totalPlayers,
    int? activeScouts,
    int? totalReports,
    int? monthlyReports,
    int? pendingReports,
    int? approvedTransfers,
    int? onlineScouts,
    List<int>? weeklyActivity,
    int? apiResponseMs,
    bool? dbStatus,
  }) {
    return DashboardStats(
      totalPlayers: totalPlayers ?? this.totalPlayers,
      activeScouts: activeScouts ?? this.activeScouts,
      totalReports: totalReports ?? this.totalReports,
      monthlyReports: monthlyReports ?? this.monthlyReports,
      pendingReports: pendingReports ?? this.pendingReports,
      approvedTransfers: approvedTransfers ?? this.approvedTransfers,
      onlineScouts: onlineScouts ?? this.onlineScouts,
      weeklyActivity: weeklyActivity ?? this.weeklyActivity,
      apiResponseMs: apiResponseMs ?? this.apiResponseMs,
      dbStatus: dbStatus ?? this.dbStatus,
    );
  }
}
