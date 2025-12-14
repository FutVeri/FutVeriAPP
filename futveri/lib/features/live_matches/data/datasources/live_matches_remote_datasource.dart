import '../models/match_dto.dart';
import '../models/match_event_dto.dart';
import '../models/match_stats_dto.dart';
import '../models/team_dto.dart';

/// Mock remote data source for live matches
/// This simulates API responses with realistic football data
class LiveMatchesRemoteDataSource {
  /// Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Get live matches
  Future<List<MatchDto>> getLiveMatches() async {
    await _simulateDelay();
    
    final now = DateTime.now();
    
    return [
      MatchDto(
        id: '1',
        homeTeam: TeamDto(
          id: 't1',
          name: 'Manchester City',
          logo: '🔵',
          formation: '4-3-3',
        ),
        awayTeam: TeamDto(
          id: 't2',
          name: 'Liverpool',
          logo: '🔴',
          formation: '4-3-3',
        ),
        homeScore: 2,
        awayScore: 1,
        status: 'live',
        minute: 67,
        startTime: now.subtract(const Duration(hours: 1)),
        league: 'Premier League',
        venue: 'Etihad Stadium',
      ),
      MatchDto(
        id: '2',
        homeTeam: TeamDto(
          id: 't3',
          name: 'Barcelona',
          logo: '🔵🔴',
          formation: '4-2-3-1',
        ),
        awayTeam: TeamDto(
          id: 't4',
          name: 'Real Madrid',
          logo: '⚪',
          formation: '4-3-3',
        ),
        homeScore: 1,
        awayScore: 1,
        status: 'halftime',
        minute: 45,
        startTime: now.subtract(const Duration(minutes: 50)),
        league: 'La Liga',
        venue: 'Camp Nou',
      ),
      MatchDto(
        id: '3',
        homeTeam: TeamDto(
          id: 't5',
          name: 'Bayern Munich',
          logo: '🔴',
          formation: '4-2-3-1',
        ),
        awayTeam: TeamDto(
          id: 't6',
          name: 'Borussia Dortmund',
          logo: '🟡⚫',
          formation: '4-4-2',
        ),
        homeScore: 3,
        awayScore: 2,
        status: 'live',
        minute: 82,
        startTime: now.subtract(const Duration(hours: 1, minutes: 30)),
        league: 'Bundesliga',
        venue: 'Allianz Arena',
      ),
      MatchDto(
        id: '4',
        homeTeam: TeamDto(
          id: 't7',
          name: 'Galatasaray',
          logo: '🟡🔴',
          formation: '4-3-3',
        ),
        awayTeam: TeamDto(
          id: 't8',
          name: 'Fenerbahçe',
          logo: '🟡🔵',
          formation: '4-2-3-1',
        ),
        homeScore: 0,
        awayScore: 0,
        status: 'live',
        minute: 23,
        startTime: now.subtract(const Duration(minutes: 25)),
        league: 'Süper Lig',
        venue: 'Türk Telekom Stadium',
      ),
    ];
  }

  /// Get match by ID
  Future<MatchDto> getMatchById(String matchId) async {
    await _simulateDelay();
    final matches = await getLiveMatches();
    return matches.firstWhere((m) => m.id == matchId);
  }

  /// Get match events
  Future<List<MatchEventDto>> getMatchEvents(String matchId) async {
    await _simulateDelay();
    
    // Different events for different matches
    switch (matchId) {
      case '1': // Man City vs Liverpool
        return [
          MatchEventDto(
            id: 'e1',
            type: 'goal',
            minute: 12,
            playerName: 'Haaland',
            teamId: 't1',
            description: 'Assisted by De Bruyne',
          ),
          MatchEventDto(
            id: 'e2',
            type: 'yellow_card',
            minute: 28,
            playerName: 'Fabinho',
            teamId: 't2',
            description: 'Tactical foul',
          ),
          MatchEventDto(
            id: 'e3',
            type: 'goal',
            minute: 34,
            playerName: 'Salah',
            teamId: 't2',
            description: 'Penalty',
          ),
          MatchEventDto(
            id: 'e4',
            type: 'substitution',
            minute: 46,
            playerName: 'Grealish → Foden',
            teamId: 't1',
          ),
          MatchEventDto(
            id: 'e5',
            type: 'goal',
            minute: 58,
            playerName: 'Álvarez',
            teamId: 't1',
            description: 'Counter-attack finish',
          ),
        ];
      
      case '2': // Barcelona vs Real Madrid
        return [
          MatchEventDto(
            id: 'e6',
            type: 'goal',
            minute: 15,
            playerName: 'Lewandowski',
            teamId: 't3',
            description: 'Header from corner',
          ),
          MatchEventDto(
            id: 'e7',
            type: 'goal',
            minute: 38,
            playerName: 'Vinícius Jr.',
            teamId: 't4',
            description: 'Solo run',
          ),
          MatchEventDto(
            id: 'e8',
            type: 'yellow_card',
            minute: 42,
            playerName: 'Casemiro',
            teamId: 't4',
          ),
        ];
      
      default:
        return [];
    }
  }

  /// Get match stats
  Future<MatchStatsDto> getMatchStats(String matchId) async {
    await _simulateDelay();
    
    switch (matchId) {
      case '1': // Man City vs Liverpool
        return MatchStatsDto(
          matchId: matchId,
          homeShots: 18,
          awayShots: 12,
          homeShotsOnTarget: 8,
          awayShotsOnTarget: 5,
          homePossession: 62,
          awayPossession: 38,
          homeXg: 2.4,
          awayXg: 1.3,
          homeCorners: 7,
          awayCorners: 4,
          homeFouls: 8,
          awayFouls: 12,
        );
      
      case '2': // Barcelona vs Real Madrid
        return MatchStatsDto(
          matchId: matchId,
          homeShots: 10,
          awayShots: 9,
          homeShotsOnTarget: 4,
          awayShotsOnTarget: 4,
          homePossession: 55,
          awayPossession: 45,
          homeXg: 1.2,
          awayXg: 1.1,
          homeCorners: 5,
          awayCorners: 3,
          homeFouls: 6,
          awayFouls: 7,
        );
      
      default:
        return MatchStatsDto(
          matchId: matchId,
          homeShots: 0,
          awayShots: 0,
          homeShotsOnTarget: 0,
          awayShotsOnTarget: 0,
          homePossession: 50,
          awayPossession: 50,
          homeXg: 0.0,
          awayXg: 0.0,
          homeCorners: 0,
          awayCorners: 0,
          homeFouls: 0,
          awayFouls: 0,
        );
    }
  }
}
