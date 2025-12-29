/// Dashboard statistics model
class DashboardStats {
  final int totalUsers;
  final int dailyActiveUsers;
  final int onlineUsers;
  final int totalReports;
  final int pendingReports;
  final int approvedReports;
  final int rejectedReports;
  final int apiResponseMs;
  final bool dbStatus;
  final List<ActivityPoint> weeklyActivity;

  const DashboardStats({
    required this.totalUsers,
    required this.dailyActiveUsers,
    required this.onlineUsers,
    required this.totalReports,
    required this.pendingReports,
    required this.approvedReports,
    required this.rejectedReports,
    required this.apiResponseMs,
    required this.dbStatus,
    required this.weeklyActivity,
  });
}

/// Activity data point for charts
class ActivityPoint {
  final DateTime date;
  final int users;
  final int reports;

  const ActivityPoint({
    required this.date,
    required this.users,
    required this.reports,
  });
}
