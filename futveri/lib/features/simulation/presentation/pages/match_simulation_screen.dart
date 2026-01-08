import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/simulation/domain/models/weekly_matches_mock.dart';
import 'package:futveri/features/simulation/domain/models/match_simulation_models.dart';
import 'package:futveri/features/simulation/domain/engine/match_engine.dart';
import 'package:futveri/features/simulation/presentation/widgets/tactical_intervention_sheet.dart';

class MatchSimulationScreen extends StatefulWidget {
  final String matchId;
  final String userTeamId;

  const MatchSimulationScreen({
    super.key,
    required this.matchId,
    required this.userTeamId,
  });

  @override
  State<MatchSimulationScreen> createState() => _MatchSimulationScreenState();
}

class _MatchSimulationScreenState extends State<MatchSimulationScreen> {
  late MatchEngine _engine;

  @override
  void initState() {
    super.initState();
    _engine = MatchEngine();
    
    final matches = WeeklyMatchesMock.getThisWeekMatches();
    final match = matches.firstWhere(
      (m) => m.id == widget.matchId,
      orElse: () => matches.first,
    );
    
    _engine.initializeMatch(match: match, userTeamId: widget.userTeamId);
    _engine.addListener(_onEngineUpdate);
  }

  void _onEngineUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _engine.removeListener(_onEngineUpdate);
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = _engine.state;
    if (state == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Score header
            _buildScoreHeader(state),
            
            // 2D Field
            Expanded(
              flex: 3,
              child: _buildField(state),
            ),
            
            // Events timeline
            Expanded(
              flex: 1,
              child: _buildEventsTimeline(state),
            ),
            
            // Control panel
            _buildControlPanel(state),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreHeader(MatchState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppTheme.surfaceDark,
      child: Column(
        children: [
          // Back button and minute
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _showExitConfirmation(),
                child: Icon(LucideIcons.x, color: Colors.white70, size: 24.sp),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: state.isPlaying 
                      ? AppTheme.primaryGreen.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: state.isPlaying 
                        ? AppTheme.primaryGreen.withOpacity(0.5)
                        : Colors.orange.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    if (state.isPlaying)
                      Icon(LucideIcons.radio, size: 12.sp, color: AppTheme.primaryGreen)
                    else
                      Icon(LucideIcons.pause, size: 12.sp, color: Colors.orange),
                    Gap(6.w),
                    Text(
                      "${state.minute}'",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _buildTacticBadge(state),
            ],
          ),
          Gap(12.h),
          
          // Score
          Row(
            children: [
              // Home team
              Expanded(
                child: Row(
                  children: [
                    _buildTeamLogo(state.homeTeam.shortName, 32),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        state.homeTeam.shortName,
                        style: TextStyle(
                          color: state.userTeamId == state.homeTeam.id 
                              ? AppTheme.primaryGreen 
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Score
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${state.homeScore} - ${state.awayScore}',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // Away team
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        state.awayTeam.shortName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: state.userTeamId == state.awayTeam.id 
                              ? AppTheme.primaryGreen 
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Gap(8.w),
                    _buildTeamLogo(state.awayTeam.shortName, 32),
                  ],
                ),
              ),
            ],
          ),
          Gap(8.h),
          
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Top', '${state.homePossession.round()}%', '${(100 - state.homePossession).round()}%'),
              _buildStatItem('Şut', '${state.homeShots}', '${state.awayShots}'),
              _buildStatItem('İsabetli', '${state.homeShotsOnTarget}', '${state.awayShotsOnTarget}'),
              _buildStatItem('Korner', '${state.homeCorners}', '${state.awayCorners}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTacticBadge(MatchState state) {
    final tactic = state.currentTactic ?? 'balanced';
    final tacticInfo = {
      'defensive': ('Defansif', Colors.blue),
      'balanced': ('Dengeli', Colors.grey),
      'attacking': ('Hücum', Colors.orange),
    };
    final info = tacticInfo[tactic]!;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: info.$2.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        info.$1,
        style: TextStyle(fontSize: 10.sp, color: info.$2, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatItem(String label, String home, String away) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 9.sp, color: AppTheme.textGrey)),
        Gap(2.h),
        Row(
          children: [
            Text(home, style: TextStyle(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.bold)),
            Text(' - ', style: TextStyle(fontSize: 11.sp, color: AppTheme.textGrey)),
            Text(away, style: TextStyle(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildField(MatchState state) {
    return Container(
      margin: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Field markings
              CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: FieldPainter(),
              ),
              
              // Home players (blue dots)
              ...state.homePositions.map((p) => _buildPlayer(
                p, constraints, 
                state.userTeamId == state.homeTeam.id ? AppTheme.primaryGreen : Colors.blue,
                isUserTeam: state.userTeamId == state.homeTeam.id,
              )),
              
              // Away players (red dots)
              ...state.awayPositions.map((p) => _buildPlayer(
                p, constraints,
                state.userTeamId == state.awayTeam.id ? AppTheme.primaryGreen : Colors.red,
                isUserTeam: state.userTeamId == state.awayTeam.id,
              )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayer(PlayerPosition p, BoxConstraints constraints, Color color, {required bool isUserTeam}) {
    final x = (p.x / 100) * constraints.maxWidth;
    final y = constraints.maxHeight - ((p.y / 100) * constraints.maxHeight);
    
    return Positioned(
      left: x - 12.w,
      top: y - 12.w,
      child: Column(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: p.hasBall ? Colors.white : color,
              shape: BoxShape.circle,
              border: Border.all(
                color: p.hasBall ? Colors.yellow : Colors.white,
                width: p.hasBall ? 3 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${p.shirtNumber}',
                style: TextStyle(
                  color: p.hasBall ? Colors.black : Colors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTimeline(MatchState state) {
    final events = state.events.reversed.take(5).toList();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Maç Olayları',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(8.h),
          Expanded(
            child: events.isEmpty
                ? Center(
                    child: Text(
                      'Maç başlamadı',
                      style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp),
                    ),
                  )
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Row(
                          children: [
                            Container(
                              width: 32.w,
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${event.minute}'",
                                style: TextStyle(fontSize: 10.sp, color: AppTheme.textGrey),
                              ),
                            ),
                            Gap(8.w),
                            Expanded(
                              child: Text(
                                event.description,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: event.type == MatchEventType.goal 
                                      ? Colors.yellow 
                                      : Colors.white70,
                                  fontWeight: event.type == MatchEventType.goal 
                                      ? FontWeight.bold 
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel(MatchState state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Play/Pause
          _buildControlButton(
            icon: state.isPlaying ? LucideIcons.pause : LucideIcons.play,
            label: state.isPlaying ? 'Durdur' : (state.minute == 0 ? 'Başlat' : 'Devam'),
            color: AppTheme.primaryGreen,
            onTap: () {
              if (state.isPlaying) {
                _engine.pauseMatch();
              } else if (state.isFullTime) {
                // Match ended
              } else {
                _engine.startMatch();
              }
            },
          ),
          
          // Tactical intervention (only when paused)
          _buildControlButton(
            icon: LucideIcons.settings2,
            label: 'Müdahale',
            color: Colors.orange,
            enabled: !state.isPlaying && !state.isFullTime,
            onTap: () => _showTacticalSheet(state),
          ),
          
          // Fast forward
          _buildControlButton(
            icon: LucideIcons.fastForward,
            label: 'Hızlı',
            color: Colors.blue,
            enabled: false, // Future feature
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            Gap(6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: enabled ? Colors.white : AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogo(String shortName, double size) {
    final colors = {
      'GS': [const Color(0xFFFFC107), const Color(0xFFD32F2F)],
      'FB': [const Color(0xFFFFEB3B), const Color(0xFF1565C0)],
      'BJK': [Colors.white, Colors.black],
      'TS': [const Color(0xFF7B1FA2), const Color(0xFF00695C)],
    };
    final teamColors = colors[shortName] ?? [Colors.grey, Colors.grey];
    
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: teamColors),
      ),
      child: Center(
        child: Text(
          shortName,
          style: TextStyle(
            color: shortName == 'BJK' ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: (size / 3).sp,
          ),
        ),
      ),
    );
  }

  void _showTacticalSheet(MatchState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TacticalInterventionSheet(
        state: state,
        onIntervention: (intervention) {
          _engine.applyIntervention(intervention);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: const Text('Maçtan Çık', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Maçtan çıkmak istediğine emin misin? İlerleme kaybolacak.',
          style: TextStyle(color: AppTheme.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal', style: TextStyle(color: AppTheme.textGrey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/simulation');
            },
            child: const Text('Çık', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for field markings
class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Center line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height * 0.15,
      paint,
    );

    // Center dot
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      4,
      paint,
    );
    paint.style = PaintingStyle.stroke;

    // Left penalty box
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.25, size.width * 0.15, size.height * 0.5),
      paint,
    );

    // Right penalty box
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.85, size.height * 0.25, size.width * 0.15, size.height * 0.5),
      paint,
    );

    // Left goal
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.35, size.width * 0.05, size.height * 0.3),
      paint,
    );

    // Right goal
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.95, size.height * 0.35, size.width * 0.05, size.height * 0.3),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
