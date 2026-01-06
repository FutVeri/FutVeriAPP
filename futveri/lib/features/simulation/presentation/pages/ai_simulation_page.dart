import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import '../../domain/models/simulation_models.dart';
import '../../domain/models/mock_simulation_data.dart';

class AiSimulationPage extends StatefulWidget {
  const AiSimulationPage({super.key});

  @override
  State<AiSimulationPage> createState() => _AiSimulationPageState();
}

class _AiSimulationPageState extends State<AiSimulationPage> {
  SimulationTeam? _homeTeam;
  SimulationTeam? _awayTeam;
  MatchAnalysis? _analysis;
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _homeTeam = MockSimulationData.galatasaray;
    _awayTeam = MockSimulationData.fenerbahce;
  }

  void _runAnalysis() async {
    if (_homeTeam == null || _awayTeam == null) return;
    
    setState(() => _isAnalyzing = true);
    
    // Simulate AI processing time
    await Future.delayed(const Duration(milliseconds: 1500));
    
    setState(() {
      _analysis = MockSimulationData.analyzeMatch(_homeTeam!, _awayTeam!);
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'AI Maç Analizi',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Team Selector Section
                  _buildTeamSelector(),
                  Gap(24.h),
                  
                  // Analyze Button
                  _buildAnalyzeButton(),
                  Gap(32.h),
                  
                  // Analysis Results
                  if (_analysis != null) ...[
                    _buildWinProbabilityCard(),
                    Gap(24.h),
                    _buildTeamComparisonCard(),
                    Gap(24.h),
                    _buildKeyPlayersCard(),
                    Gap(24.h),
                    _buildTacticalSuggestionsCard(),
                    Gap(24.h),
                    _buildFormationComparisonCard(),
                    Gap(40.h),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSelector() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Takımları Seç',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: _buildTeamDropdown(
                  label: 'Ev Sahibi',
                  selectedTeam: _homeTeam,
                  onChanged: (team) => setState(() {
                    _homeTeam = team;
                    _analysis = null;
                  }),
                  excludeTeam: _awayTeam,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'VS',
                    style: TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _buildTeamDropdown(
                  label: 'Deplasman',
                  selectedTeam: _awayTeam,
                  onChanged: (team) => setState(() {
                    _awayTeam = team;
                    _analysis = null;
                  }),
                  excludeTeam: _homeTeam,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamDropdown({
    required String label,
    required SimulationTeam? selectedTeam,
    required Function(SimulationTeam?) onChanged,
    SimulationTeam? excludeTeam,
  }) {
    final availableTeams = MockSimulationData.teams
        .where((t) => t.id != excludeTeam?.id)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textGrey,
            fontSize: 12.sp,
          ),
        ),
        Gap(8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SimulationTeam>(
              value: selectedTeam,
              isExpanded: true,
              dropdownColor: AppTheme.surfaceDark,
              icon: Icon(LucideIcons.chevronDown, size: 18.sp, color: AppTheme.textGrey),
              items: availableTeams.map((team) {
                return DropdownMenuItem(
                  value: team,
                  child: Text(
                    team.shortName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton() {
    return GestureDetector(
      onTap: _isAnalyzing ? null : _runAnalysis,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isAnalyzing 
                ? [Colors.grey.shade700, Colors.grey.shade800]
                : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isAnalyzing ? [] : [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isAnalyzing) ...[
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              Gap(12.w),
              Text(
                'AI Analiz Yapıyor...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              Icon(LucideIcons.bot, color: Colors.white, size: 22.sp),
              Gap(12.w),
              Text(
                'Maçı Analiz Et',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWinProbabilityCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.pieChart, color: AppTheme.primaryGreen, size: 20.sp),
              Gap(8.w),
              Text(
                'Kazanma Olasılığı',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(
                child: _buildProbabilityItem(
                  _analysis!.homeTeam.shortName,
                  _analysis!.homeWinProbability,
                  const Color(0xFF10B981),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: _buildProbabilityItem(
                  'Beraberlik',
                  _analysis!.drawProbability,
                  const Color(0xFFF59E0B),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: _buildProbabilityItem(
                  _analysis!.awayTeam.shortName,
                  _analysis!.awayWinProbability,
                  const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProbabilityItem(String label, double probability, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
          ),
          child: Text(
            '${probability.toStringAsFixed(0)}%',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
        Gap(8.h),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textGrey,
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTeamComparisonCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.barChart2, color: AppTheme.primaryGreen, size: 20.sp),
              Gap(8.w),
              Text(
                'Takım Karşılaştırması',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(20.h),
          _buildComparisonBar('Atak', _analysis!.homeTeam.strengths.attack, _analysis!.awayTeam.strengths.attack),
          Gap(12.h),
          _buildComparisonBar('Orta Saha', _analysis!.homeTeam.strengths.midfield, _analysis!.awayTeam.strengths.midfield),
          Gap(12.h),
          _buildComparisonBar('Defans', _analysis!.homeTeam.strengths.defense, _analysis!.awayTeam.strengths.defense),
          Gap(12.h),
          _buildComparisonBar('Duran Top', _analysis!.homeTeam.strengths.setPieces, _analysis!.awayTeam.strengths.setPieces),
        ],
      ),
    );
  }

  Widget _buildComparisonBar(String label, int homeValue, int awayValue) {
    final total = homeValue + awayValue;
    final homeRatio = homeValue / total;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$homeValue', style: TextStyle(color: const Color(0xFF10B981), fontSize: 12.sp, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp)),
            Text('$awayValue', style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        Gap(6.h),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFEF4444).withOpacity(0.3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: homeRatio,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFF10B981),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyPlayersCard() {
    final homeKeyPlayers = _analysis!.homeTeam.players.where((p) => p.isKeyPlayer).toList();
    final awayKeyPlayers = _analysis!.awayTeam.players.where((p) => p.isKeyPlayer).toList();
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.star, color: AppTheme.primaryGreen, size: 20.sp),
              Gap(8.w),
              Text(
                'Anahtar Oyuncular',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _analysis!.homeTeam.shortName,
                      style: TextStyle(
                        color: const Color(0xFF10B981),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Gap(8.h),
                    ...homeKeyPlayers.map((p) => _buildPlayerItem(p, const Color(0xFF10B981))),
                  ],
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _analysis!.awayTeam.shortName,
                      style: TextStyle(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Gap(8.h),
                    ...awayKeyPlayers.map((p) => _buildPlayerItem(p, const Color(0xFFEF4444))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerItem(SimulationPlayer player, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${player.number}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Gap(8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  player.position,
                  style: TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${player.rating.toStringAsFixed(0)}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTacticalSuggestionsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.lightbulb, color: const Color(0xFFF59E0B), size: 20.sp),
              Gap(8.w),
              Text(
                'AI Taktik Önerileri',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(16.h),
          ..._analysis!.suggestions.map((suggestion) => _buildSuggestionItem(suggestion)),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(TacticalSuggestion suggestion) {
    Color priorityColor;
    switch (suggestion.priority) {
      case 'high':
        priorityColor = const Color(0xFFEF4444);
        break;
      case 'medium':
        priorityColor = const Color(0xFFF59E0B);
        break;
      default:
        priorityColor = const Color(0xFF10B981);
    }

    IconData categoryIcon;
    switch (suggestion.category) {
      case 'attack':
        categoryIcon = LucideIcons.swords;
        break;
      case 'defense':
        categoryIcon = LucideIcons.shield;
        break;
      case 'midfield':
        categoryIcon = LucideIcons.target;
        break;
      default:
        categoryIcon = LucideIcons.flag;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: priorityColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: priorityColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(categoryIcon, color: priorityColor, size: 18.sp),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(4.h),
                Text(
                  suggestion.description,
                  style: TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationComparisonCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.layout, color: AppTheme.primaryGreen, size: 20.sp),
              Gap(8.w),
              Text(
                'Diziliş Karşılaştırması',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(
                child: _buildFormationCard(
                  _analysis!.homeTeam.shortName,
                  _analysis!.homeTeam.formation,
                  const Color(0xFF10B981),
                ),
              ),
              Gap(16.w),
              Expanded(
                child: _buildFormationCard(
                  _analysis!.awayTeam.shortName,
                  _analysis!.awayTeam.formation,
                  const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          Gap(16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.info, color: const Color(0xFF6366F1), size: 18.sp),
                Gap(8.w),
                Expanded(
                  child: Text(
                    '${_analysis!.homeTeam.formation} dizilişi, ${_analysis!.awayTeam.formation} karşısında orta saha kontrolünde avantaj sağlayabilir.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationCard(String teamName, String formation, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            teamName,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          Gap(8.h),
          Text(
            formation,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
