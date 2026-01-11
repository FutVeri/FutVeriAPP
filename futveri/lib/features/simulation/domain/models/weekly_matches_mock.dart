/// Weekly matches mock data for simulation
/// Provides this week's match fixtures for Süper Lig

import 'simulation_models.dart';
import 'mock_simulation_data.dart';
import 'match_simulation_models.dart';

/// Generate weekly match fixtures
class WeeklyMatchesMock {
  /// Get this week's matches (defaults to 18)
  static List<WeeklyMatch> getThisWeekMatches() {
    return getMatchesForWeek(18);
  }

  /// Get matches for a specific week (1-34)
  static List<WeeklyMatch> getMatchesForWeek(int week) {
    final now = DateTime.now();
    // Offset based on week number to make matches appear on different dates
    final baseDate = now.add(Duration(days: (week - 18) * 7));
    final saturday = baseDate.add(Duration(days: (6 - baseDate.weekday) % 7));
    final sunday = saturday.add(const Duration(days: 1));

    // Simple rotation of matchups based on week to simulate a league
    final rotation = week % 4;
    
    switch (rotation) {
      case 0:
        return [
          WeeklyMatch(
            id: 'match_${week}_1',
            homeTeam: MockSimulationData.galatasaray,
            awayTeam: MockSimulationData.fenerbahce,
            matchDateTime: DateTime(saturday.year, saturday.month, saturday.day, 19, 0),
            stadium: 'Rams Park',
            matchweek: week,
          ),
          WeeklyMatch(
            id: 'match_${week}_2',
            homeTeam: MockSimulationData.besiktas,
            awayTeam: MockSimulationData.trabzonspor,
            matchDateTime: DateTime(saturday.year, saturday.month, saturday.day, 16, 0),
            stadium: 'Tüpraş Stadyumu',
            matchweek: week,
          ),
        ];
      case 1:
        return [
          WeeklyMatch(
            id: 'match_${week}_1',
            homeTeam: MockSimulationData.trabzonspor,
            awayTeam: MockSimulationData.galatasaray,
            matchDateTime: DateTime(sunday.year, sunday.month, sunday.day, 19, 0),
            stadium: 'Papara Park',
            matchweek: week,
          ),
          WeeklyMatch(
            id: 'match_${week}_2',
            homeTeam: MockSimulationData.fenerbahce,
            awayTeam: MockSimulationData.besiktas,
            matchDateTime: DateTime(sunday.year, sunday.month, sunday.day, 21, 0),
            stadium: 'Ülker Stadyumu',
            matchweek: week,
          ),
        ];
      case 2:
        return [
          WeeklyMatch(
            id: 'match_${week}_1',
            homeTeam: MockSimulationData.galatasaray,
            awayTeam: MockSimulationData.besiktas,
            matchDateTime: DateTime(saturday.year, saturday.month, saturday.day, 20, 0),
            stadium: 'Rams Park',
            matchweek: week,
          ),
          WeeklyMatch(
            id: 'match_${week}_2',
            homeTeam: MockSimulationData.fenerbahce,
            awayTeam: MockSimulationData.trabzonspor,
            matchDateTime: DateTime(sunday.year, sunday.month, sunday.day, 18, 0),
            stadium: 'Ülker Stadyumu',
            matchweek: week,
          ),
        ];
      default:
        return [
          WeeklyMatch(
            id: 'match_${week}_1',
            homeTeam: MockSimulationData.besiktas,
            awayTeam: MockSimulationData.fenerbahce,
            matchDateTime: DateTime(saturday.year, saturday.month, saturday.day, 19, 0),
            stadium: 'Tüpraş Stadyumu',
            matchweek: week,
          ),
          WeeklyMatch(
            id: 'match_${week}_2',
            homeTeam: MockSimulationData.trabzonspor,
            awayTeam: MockSimulationData.galatasaray,
            matchDateTime: DateTime(sunday.year, sunday.month, sunday.day, 16, 0),
            stadium: 'Papara Park',
            matchweek: week,
          ),
        ];
    }
  }

  /// Get initial player positions for a 4-3-3 formation (home team plays left to right)
  static List<PlayerPosition> getHomeFormationPositions(SimulationTeam team) {
    final players = team.players;
    // We assume first 11 are starters
    return [
      // GK (Line 1)
      PlayerPosition(playerId: players[0].id, playerName: players[0].name, shirtNumber: players[0].number, x: 5, y: 50, position: 'GK'),
      
      // Defenders (Line 2)
      PlayerPosition(playerId: players[8].id, playerName: players[8].name, shirtNumber: players[8].number, x: 20, y: 80, position: 'RB'),
      PlayerPosition(playerId: players[4].id, playerName: players[4].name, shirtNumber: players[4].number, x: 20, y: 60, position: 'CB'),
      PlayerPosition(playerId: players[5].id, playerName: players[5].name, shirtNumber: players[5].number, x: 20, y: 40, position: 'CB'),
      PlayerPosition(playerId: players[9].id, playerName: players[9].name, shirtNumber: players[9].number, x: 20, y: 20, position: 'LB'),
      
      // Midfielders (Line 3)
      PlayerPosition(playerId: players[3].id, playerName: players[3].name, shirtNumber: players[3].number, x: 40, y: 65, position: 'CDM'),
      PlayerPosition(playerId: players[7].id, playerName: players[7].name, shirtNumber: players[7].number, x: 45, y: 45, position: 'CM'),
      PlayerPosition(playerId: players[2].id, playerName: players[2].name, shirtNumber: players[2].number, x: 40, y: 25, position: 'CAM'),
      
      // Forwards (Line 4)
      PlayerPosition(playerId: players[6].id, playerName: players[6].name, shirtNumber: players[6].number, x: 65, y: 80, position: 'RW'),
      PlayerPosition(playerId: players[1].id, playerName: players[1].name, shirtNumber: players[1].number, x: 70, y: 50, hasBall: true, position: 'ST'),
      PlayerPosition(playerId: players[10].id, playerName: players[10].name, shirtNumber: players[10].number, x: 65, y: 20, position: 'LW'),
    ];
  }

  /// Get initial player positions for away team (plays right to left)
  static List<PlayerPosition> getAwayFormationPositions(SimulationTeam team) {
    final players = team.players;
    return [
      // GK
      PlayerPosition(playerId: players[0].id, playerName: players[0].name, shirtNumber: players[0].number, x: 95, y: 50, position: 'GK'),
      
      // Defenders
      PlayerPosition(playerId: players[8].id, playerName: players[8].name, shirtNumber: players[8].number, x: 80, y: 20, position: 'RB'),
      PlayerPosition(playerId: players[4].id, playerName: players[4].name, shirtNumber: players[4].number, x: 80, y: 40, position: 'CB'),
      PlayerPosition(playerId: players[5].id, playerName: players[5].name, shirtNumber: players[5].number, x: 80, y: 60, position: 'CB'),
      PlayerPosition(playerId: players[9].id, playerName: players[9].name, shirtNumber: players[9].number, x: 80, y: 80, position: 'LB'),
      
      // Midfielders
      PlayerPosition(playerId: players[3].id, playerName: players[3].name, shirtNumber: players[3].number, x: 60, y: 35, position: 'CDM'),
      PlayerPosition(playerId: players[7].id, playerName: players[7].name, shirtNumber: players[7].number, x: 55, y: 55, position: 'CM'),
      PlayerPosition(playerId: players[2].id, playerName: players[2].name, shirtNumber: players[2].number, x: 60, y: 75, position: 'CAM'),
      
      // Forwards
      PlayerPosition(playerId: players[6].id, playerName: players[6].name, shirtNumber: players[6].number, x: 35, y: 20, position: 'RW'),
      PlayerPosition(playerId: players[1].id, playerName: players[1].name, shirtNumber: players[1].number, x: 30, y: 50, position: 'ST'),
      PlayerPosition(playerId: players[10].id, playerName: players[10].name, shirtNumber: players[10].number, x: 35, y: 80, position: 'LW'),
    ];
  }
}

// ============================================================
// SUPABASE INTEGRATION - Future Implementation
// Uncomment when ready to fetch real fixtures from Supabase
// ============================================================

// class WeeklyMatchesService {
//   /// Fetch this week's matches from Supabase
//   /// Table: match_fixtures (id, home_team_id, away_team_id, match_datetime, stadium, matchweek, competition)
//   static Future<List<WeeklyMatch>> fetchThisWeekMatches() async {
//     final now = DateTime.now();
//     final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
//     final endOfWeek = startOfWeek.add(const Duration(days: 7));
//     
//     final response = await supabase.client
//         .from('match_fixtures')
//         .select('*, home_team:teams!home_team_id(*), away_team:teams!away_team_id(*)')
//         .gte('match_datetime', startOfWeek.toIso8601String())
//         .lte('match_datetime', endOfWeek.toIso8601String())
//         .order('match_datetime');
//     
//     return (response as List).map((e) => WeeklyMatch.fromJson(e)).toList();
//   }
// }
