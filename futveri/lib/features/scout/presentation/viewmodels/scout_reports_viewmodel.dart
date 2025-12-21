import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';

// State for Scout Reports List
class ScoutReportsState {
  final List<ScoutReport> reports;
  final bool isLoading;

  ScoutReportsState({
    this.reports = const [],
    this.isLoading = false,
  });

  ScoutReportsState copyWith({
    List<ScoutReport>? reports,
    bool? isLoading,
  }) {
    return ScoutReportsState(
      reports: reports ?? this.reports,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ScoutReportsViewModel extends Notifier<ScoutReportsState> {
  @override
  ScoutReportsState build() {
    return ScoutReportsState(
      reports: _getMockReports(),
    );
  }

  List<ScoutReport> _getMockReports() {
    return [
      ScoutReport(
        id: '1',
        playerId: 'p1',
        playerName: 'Semih Kılıçsoy',
        playerPosition: 'ST',
        playerAge: 19,
        playerTeam: 'Beşiktaş',
        matchDate: DateTime.now().subtract(const Duration(days: 2)),
        rivalTeam: 'Galatasaray',
        score: '2-1',
        minutePlayed: 90,
        matchType: 'Stadium',
        ratings: {
          'Technique': 9,
          'Pace': 8,
          'Finishing': 9,
          'Physicality': 7,
        },
        physicalAttributes: 'Strong and resilient.',
        technicalAttributes: 'Excellent finishing and dribbling.',
        tacticalAttributes: 'Great positioning.',
        metalAttributes: 'Highly motivated.',
        strengths: 'Finishing, Strength',
        weaknesses: 'Experience',
        risks: 'Injuries',
        recommendedRole: 'Target Man',
        scoutId: 's1',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        description: 'Incredible finishing ability for his age. Needs to improve decision making in tight spaces. exceptional potential.',
        imageUrls: [],
        status: 'submitted',
      ),
      ScoutReport(
        id: '2',
        playerId: 'p2',
        playerName: 'Arda Güler',
        playerPosition: 'CAM',
        playerAge: 19,
        playerTeam: 'Real Madrid',
        matchDate: DateTime.now().subtract(const Duration(days: 5)),
        rivalTeam: 'Barcelona',
        score: '3-2',
        minutePlayed: 75,
        matchType: 'Stadium',
        ratings: {
          'Technique': 10,
          'Vision': 10,
          'Passing': 9,
          'Pace': 7,
        },
        physicalAttributes: 'Lean, needs more muscle.',
        technicalAttributes: 'World class technique.',
        tacticalAttributes: 'IQ is very high.',
        metalAttributes: 'Confident.',
        strengths: 'Vision, Passing, Technique',
        weaknesses: 'Physicality',
        risks: 'Game time',
        recommendedRole: 'Playmaker',
        scoutId: 's1',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        description: 'Transcendental talent with the ball. His vision is unparalleled in his age group.',
        imageUrls: [],
        status: 'approved',
      ),
      ScoutReport(
        id: '3',
        playerId: 'p3',
        playerName: 'Kenan Yıldız',
        playerPosition: 'LW',
        playerAge: 19,
        playerTeam: 'Juventus',
        matchDate: DateTime.now().subtract(const Duration(days: 10)),
        rivalTeam: 'Inter',
        score: '1-1',
        minutePlayed: 82,
        matchType: 'Stadium',
        ratings: {
          'Technique': 9,
          'Dribbling': 9,
          'Pace': 8,
          'Aggression': 8,
        },
        physicalAttributes: 'Strong and fast.',
        technicalAttributes: 'Great dribbler.',
        tacticalAttributes: 'Versatile.',
        metalAttributes: 'Clutch player.',
        strengths: 'Dribbling, Versatility',
        weaknesses: 'Consistency',
        risks: 'None',
        recommendedRole: 'Inside Forward',
        scoutId: 's1',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        description: 'Dynamic winger with great 1v1 ability. Shows great maturity in big games.',
        imageUrls: [],
        status: 'submitted',
      ),
    ];
  }
}

final scoutReportsProvider = NotifierProvider<ScoutReportsViewModel, ScoutReportsState>(() {
  return ScoutReportsViewModel();
});
