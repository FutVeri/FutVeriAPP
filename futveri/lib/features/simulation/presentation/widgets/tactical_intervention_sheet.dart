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

  @override
  void initState() {
    super.initState();
    selectedMentality = widget.state.currentTactic;
  }

  @override
  Widget build(BuildContext context) {
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
          
          // Formation section
          Text(
            'Formasyon',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildFormationChip('4-4-2'),
              _buildFormationChip('4-3-3'),
              _buildFormationChip('4-2-3-1'),
              _buildFormationChip('3-5-2'),
              _buildFormationChip('5-3-2'),
            ],
          ),
          Gap(24.h),
          
          // Substitution placeholder
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.userMinus, color: AppTheme.textGrey, size: 20.sp),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oyuncu Değişikliği',
                        style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                      Text(
                        'Yakında eklenecek',
                        style: TextStyle(color: AppTheme.textGrey, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.lock, color: AppTheme.textGrey, size: 16.sp),
              ],
            ),
          ),
          Gap(16.h),
          
          // LLM AI Coach placeholder
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withOpacity(0.1),
                  const Color(0xFF8B5CF6).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.bot, color: const Color(0xFF6366F1), size: 20.sp),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Koç Önerisi',
                        style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                      Text(
                        'LLM entegrasyonu ile taktik öneriler',
                        style: TextStyle(color: AppTheme.textGrey, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'YAKINDA',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(24.h),
          
          // Apply button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (selectedMentality != null && selectedMentality != widget.state.currentTactic) {
                  widget.onIntervention(TacticalIntervention(
                    type: 'mentality',
                    mentality: selectedMentality,
                  ));
                } else if (selectedFormation != null) {
                  widget.onIntervention(TacticalIntervention(
                    type: 'formation',
                    newFormation: selectedFormation,
                  ));
                } else {
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

  Widget _buildFormationChip(String formation) {
    final isSelected = selectedFormation == formation;
    
    return GestureDetector(
      onTap: () => setState(() => selectedFormation = formation),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGreen.withOpacity(0.2) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGreen : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          formation,
          style: TextStyle(
            fontSize: 12.sp,
            color: isSelected ? AppTheme.primaryGreen : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
