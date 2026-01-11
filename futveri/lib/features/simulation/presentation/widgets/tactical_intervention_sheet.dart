import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/simulation/domain/models/match_simulation_models.dart';

class TacticalInterventionSheet extends StatefulWidget {
  final MatchState state;
  final Function(TacticalIntervention) onIntervention;

  const TacticalInterventionSheet({
    super.key,
    required this.state,
    required this.onIntervention,
  });

  @override
  State<TacticalInterventionSheet> createState() => _TacticalInterventionSheetState();
}

class _TacticalInterventionSheetState extends State<TacticalInterventionSheet> {
  String? selectedMentality;
  String? selectedFormation;
  String? selectedPlayerOutId;
  String? selectedPlayerInId;

  @override
  void initState() {
    super.initState();
    selectedMentality = widget.state.currentTactic;
  }

  @override
  Widget build(BuildContext context) {
    final isHomeTeam = widget.state.userTeamId == widget.state.homeTeam.id;
    final onFieldPlayers = isHomeTeam ? widget.state.homePositions : widget.state.awayPositions;
    final benchPlayers = isHomeTeam ? widget.state.homeBench : widget.state.awayBench;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Gap(20.h),
          
          // Title
          Row(
            children: [
              Icon(LucideIcons.settings2, color: Colors.orange, size: 24.sp),
              Gap(12.w),
              Text(
                'Taktik Müdahale',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            "Dakika: ${widget.state.minute}'",
            style: TextStyle(fontSize: 12.sp, color: AppTheme.textGrey),
          ),
          Gap(24.h),
          
          // Mentality section
          Text(
            'Oyun Anlayışı',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(12.h),
          Row(
            children: [
              _buildMentalityChip('defensive', 'Defansif', LucideIcons.shield, Colors.blue),
              Gap(8.w),
              _buildMentalityChip('balanced', 'Dengeli', LucideIcons.scale, Colors.grey),
              Gap(8.w),
              _buildMentalityChip('attacking', 'Hücum', LucideIcons.swords, Colors.orange),
            ],
          ),
          Gap(24.h),
          
          // Substitution section
          Text(
            'Oyuncu Değişikliği',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Players on field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Çıkan Oyuncu', style: TextStyle(fontSize: 11.sp, color: AppTheme.textGrey)),
                    Gap(8.h),
                    Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        itemCount: onFieldPlayers.length,
                        itemBuilder: (context, index) {
                          final player = onFieldPlayers[index];
                          final isSelected = selectedPlayerOutId == player.playerId;
                          return ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: Text(
                              player.playerName,
                              style: TextStyle(
                                fontSize: 11.sp, 
                                color: isSelected ? Colors.red : Colors.white70,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(player.position, style: TextStyle(fontSize: 9.sp, color: AppTheme.textGrey)),
                            trailing: Text('#${player.shirtNumber}', style: TextStyle(fontSize: 10.sp, color: AppTheme.textGrey)),
                            onTap: () => setState(() => selectedPlayerOutId = player.playerId),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Gap(12.w),
              // Bench players
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Giren Oyuncu', style: TextStyle(fontSize: 11.sp, color: AppTheme.textGrey)),
                    Gap(8.h),
                    Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: benchPlayers.isEmpty 
                        ? Center(child: Text('Yedek yok', style: TextStyle(fontSize: 10.sp, color: AppTheme.textGrey)))
                        : ListView.builder(
                            itemCount: benchPlayers.length,
                            itemBuilder: (context, index) {
                              final player = benchPlayers[index];
                              final isSelected = selectedPlayerInId == player.id;
                              return ListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  player.name,
                                  style: TextStyle(
                                    fontSize: 11.sp, 
                                    color: isSelected ? AppTheme.primaryGreen : Colors.white70,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(player.position, style: TextStyle(fontSize: 9.sp, color: AppTheme.textGrey)),
                                trailing: Text('#${player.number}', style: TextStyle(fontSize: 10.sp, color: AppTheme.textGrey)),
                                onTap: () => setState(() => selectedPlayerInId = player.id),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(24.h),
          
          // Apply button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle mentality change first if any
                if (selectedMentality != null && selectedMentality != widget.state.currentTactic) {
                  widget.onIntervention(TacticalIntervention(
                    type: 'mentality',
                    mentality: selectedMentality,
                  ));
                }
                
                // Handle substitution
                if (selectedPlayerOutId != null && selectedPlayerInId != null) {
                  widget.onIntervention(TacticalIntervention(
                    type: 'substitution',
                    playerOutId: selectedPlayerOutId,
                    playerInId: selectedPlayerInId,
                  ));
                }
                
                // Close if something was selected or just to close
                if ((selectedMentality == widget.state.currentTactic || selectedMentality == null) && 
                    (selectedPlayerOutId == null || selectedPlayerInId == null)) {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Uygula ve Devam Et',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _buildMentalityChip(String value, String label, IconData icon, Color color) {
    final isSelected = selectedMentality == value;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedMentality = value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? color : AppTheme.textGrey, size: 20.sp),
              Gap(4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isSelected ? color : AppTheme.textGrey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LLM INTEGRATION - Future Implementation
// Uncomment when ready to integrate with LLM for AI coaching
// ============================================================

// class AICoachService {
//   /// Get tactical suggestion from LLM
//   /// Uses current match state to generate advice
//   static Future<String> getTacticalAdvice(MatchState state) async {
//     final prompt = '''
//     Maç Durumu:
//     - Dakika: ${state.minute}
//     - Skor: ${state.homeTeam.shortName} ${state.homeScore} - ${state.awayScore} ${state.awayTeam.shortName}
//     - Top Hakimiyeti: %${state.homePossession.round()} - %${(100 - state.homePossession).round()}
//     - Şutlar: ${state.homeShots} - ${state.awayShots}
//     
//     Ben ${state.userTeamId == state.homeTeam.id ? state.homeTeam.name : state.awayTeam.name} teknik direktörüyüm.
//     Ne yapmalıyım?
//     ''';
//     
//     // Call LLM API here
//     // final response = await llmService.generate(prompt);
//     // return response;
//     
//     return 'AI önerisi yükleniyor...';
//   }
// }
