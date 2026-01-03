import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../core/supabase/supabase_client.dart';
import '../../models/scout_report.dart';
import '../../models/dashboard_stats.dart';
import 'widgets/stat_card.dart';
import 'widgets/activity_chart.dart';
import 'widgets/recent_reports_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = true;
  DashboardStats _stats = const DashboardStats(
    totalPlayers: 0,
    totalReports: 0,
    activeScouts: 0,
    monthlyReports: 0,
  );
  List<ScoutReport> _recentReports = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      // Fetch stats
      final results = await Future.wait([
        supabase.client.from('players').select('id', const FetchOptions(count: CountOption.exact)),
        supabase.client.from('scout_reports').select('id', const FetchOptions(count: CountOption.exact)),
        supabase.client.from('users').select('id', const FetchOptions(count: CountOption.exact)).eq('role', 'scout').eq('is_active', true),
        supabase.client.from('scout_reports').select().order('created_at', ascending: false).limit(5),
      ]);

      final playersCount = (results[0] as PostgrestResponse).count ?? 0;
      final reportsCount = (results[1] as PostgrestResponse).count ?? 0;
      final scoutsCount = (results[2] as PostgrestResponse).count ?? 0;
      
      final reportsData = results[3] as List;
      final reports = reportsData.map((data) {
        return ScoutReport(
          id: data['id'] as String,
          playerName: data['player_name'] as String,
          scoutName: 'Scout',
          scoutId: data['scout_id'] as String,
          playerAge: data['player_age'] as int,
          position: data['player_position'] as String,
          currentClub: data['player_team'] as String,
          createdAt: DateTime.parse(data['created_at'] as String),
          status: _parseStatus(data['status']),
          physical: RatingDetails(value: data['physical_rating'] as int, description: ''),
          technical: RatingDetails(value: data['technical_rating'] as int, description: ''),
          tactical: RatingDetails(value: data['tactical_rating'] as int, description: ''),
          mental: RatingDetails(value: data['mental_rating'] as int, description: ''),
          overall: RatingDetails(value: (data['overall_rating'] as num).round(), description: ''),
          potential: RatingDetails(value: (data['potential_rating'] as num).round(), description: ''),
        );
      }).toList();

      setState(() {
        _stats = DashboardStats(
          totalPlayers: playersCount,
          totalReports: reportsCount,
          activeScouts: scoutsCount,
          monthlyReports: 0, // Simplified for now
          dbStatus: true,
          apiResponseMs: 120,
        );
        _recentReports = reports;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading dashboard: $e');
      setState(() {
        _isLoading = false;
        _stats = _stats.copyWith(dbStatus: false);
      });
    }
  }

  ReportStatus _parseStatus(dynamic statusStr) {
    switch (statusStr) {
      case 'approved': return ReportStatus.approved;
      case 'rejected': return ReportStatus.rejected;
      default: return ReportStatus.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),
              const Gap(32),
              // Stats Row
              _buildStatsRow(),
              const Gap(24),
              // Charts and Lists Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity Chart
                  Expanded(
                    flex: 2,
                    child: ActivityChart(data: _stats.weeklyActivity),
                  ),
                  const Gap(16),
                  // Recent Reports
                  Expanded(
                    child: RecentReportsWidget(
                      reports: _recentReports,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textWhite,
                  ),
            ),
            const Gap(4),
            Text(
              'Kulüp panelinize hoş geldiniz',
              style: TextStyle(
                color: AppTheme.textGrey.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        // System Status
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: 12,
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _stats.dbStatus
                      ? AppTheme.successGreen
                      : AppTheme.errorRed,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_stats.dbStatus
                              ? AppTheme.successGreen
                              : AppTheme.errorRed)
                          .withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Text(
                'API: ${_stats.apiResponseMs}ms',
                style: const TextStyle(
                  color: AppTheme.textGrey,
                  fontSize: 13,
                ),
              ),
              const Gap(12),
              Text(
                'DB: ${_stats.dbStatus ? "OK" : "Error"}',
                style: TextStyle(
                  color: _stats.dbStatus
                      ? AppTheme.successGreen
                      : AppTheme.errorRed,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: LucideIcons.users,
            label: 'Toplam Oyuncu',
            value: _stats.totalPlayers.toString(),
            trend: '+8%',
            trendUp: true,
            accentColor: AppTheme.primaryGreen,
          ),
        ),
        const Gap(16),
        Expanded(
          child: StatCard(
            icon: LucideIcons.scan,
            label: 'Aktif Scout',
            value: _stats.activeScouts.toString(),
            trend: '+2',
            trendUp: true,
            accentColor: AppTheme.secondaryBlue,
          ),
        ),
        const Gap(16),
        Expanded(
          child: StatCard(
            icon: LucideIcons.fileText,
            label: 'Toplam Rapor',
            value: _stats.totalReports.toString(),
            accentColor: AppTheme.warningOrange,
          ),
        ),
        const Gap(16),
        Expanded(
          child: StatCard(
            icon: LucideIcons.checkCircle,
            label: 'Aylık Rapor',
            value: _stats.monthlyReports.toString(),
            accentColor: AppTheme.successGreen,
          ),
        ),
      ],
    );
  }
}
