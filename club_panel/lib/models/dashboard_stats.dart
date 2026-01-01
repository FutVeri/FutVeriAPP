/// Dashboard statistics model
class DashboardStats {
  final int totalPlayers;
  final int activeScouts;
  final int pendingReports;
  final int approvedTransfers;
  final int onlineScouts;
  final List<int> weeklyActivity;
  final int apiResponseMs;
  final bool dbStatus;

  const DashboardStats({
    required this.totalPlayers,
    required this.activeScouts,
    required this.pendingReports,
    required this.approvedTransfers,
    required this.onlineScouts,
    required this.weeklyActivity,
    required this.apiResponseMs,
    required this.dbStatus,
  });
}
