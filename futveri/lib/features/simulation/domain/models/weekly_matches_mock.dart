/// Weekly matches mock data for simulation
/// Provides this week's match fixtures for Süper Lig

import 'simulation_models.dart';
import 'mock_simulation_data.dart';
import 'match_simulation_models.dart';

/// Generate weekly match fixtures
class WeeklyMatchesMock {
  /// Get this week's matches
  static List<WeeklyMatch> getThisWeekMatches() {
    final now = DateTime.now();
    final saturday = now.add(Duration(days: (6 - now.weekday) % 7));
    final sunday = saturday.add(const Duration(days: 1));

    return [
      WeeklyMatch(
        id: 'match_1',
        homeTeam: MockSimulationData.galatasaray,
        awayTeam: MockSimulationData.fenerbahce,
        matchDateTime: DateTime(saturday.year, saturday.month, saturday.day, 19, 0),
        stadium: 'Rams Park',
        matchweek: 18,
      ),
      WeeklyMatch(
        id: 'match_2',
        homeTeam: MockSimulationData.besiktas,
        awayTeam: MockSimulationData.trabzonspor,
        matchDateTime: DateTime(saturday.year, saturday.month, saturday.day, 16, 0),
        stadium: 'Tüpraş Stadyumu',
        matchweek: 18,
      ),
      WeeklyMatch(
        id: 'match_3',
        homeTeam: MockSimulationData.trabzonspor,
        awayTeam: MockSimulationData.galatasaray,
        matchDateTime: DateTime(sunday.year, sunday.month, sunday.day, 19, 0),
        stadium: 'Papara Park',
        matchweek: 18,
      ),
      WeeklyMatch(
        id: 'match_4',
        homeTeam: MockSimulationData.fenerbahce,
        awayTeam: MockSimulationData.besiktas,
        matchDateTime: DateTime(sunday.year, sunday.month, sunday.day, 21, 0),
        stadium: 'Ülker Stadyumu',
        matchweek: 18,
      ),
    ];
  }

  /// Get initial player positions for a 4-3-3 formation (home team plays left to right)
  static List<PlayerPosition> getHomeFormationPositions(SimulationTeam team) {
    final players = team.players;
    return [
      // GK
      PlayerPosition(playerId: players[0].id, playerName: players[0].name, shirtNumber: players[0].number, x: 5, y: 50, position: 'GK'),
      // Defenders
      PlayerPosition(playerId: '${team.id}_def1', playerName: 'Savunma 1', shirtNumber: 2, x: 20, y: 80, position: 'RB'),
      PlayerPosition(playerId: '${team.id}_def2', playerName: 'Savunma 2', shirtNumber: 4, x: 20, y: 60, position: 'CB'),
      PlayerPosition(playerId: players.length > 4 ? players[4].id : '${team.id}_def3', playerName: players.length > 4 ? players[4].name : 'Savunma 3', shirtNumber: players.length > 4 ? players[4].number : 5, x: 20, y: 40, position: 'CB'),
      PlayerPosition(playerId: '${team.id}_def4', playerName: 'Savunma 4', shirtNumber: 3, x: 20, y: 20, position: 'LB'),
      // Midfielders
      PlayerPosition(playerId: players.length > 3 ? players[3].id : '${team.id}_mid1', playerName: players.length > 3 ? players[3].name : 'Orta Saha 1', shirtNumber: players.length > 3 ? players[3].number : 6, x: 40, y: 70, position: 'CM'),
      PlayerPosition(playerId: '${team.id}_mid2', playerName: 'Orta Saha 2', shirtNumber: 8, x: 40, y: 50, position: 'CM'),
      PlayerPosition(playerId: '${team.id}_mid3', playerName: 'Orta Saha 3', shirtNumber: 10, x: 40, y: 30, position: 'CM'),
      // Forwards
      PlayerPosition(playerId: '${team.id}_fw1', playerName: 'Forvet 1', shirtNumber: 7, x: 60, y: 75, position: 'RW'),
      PlayerPosition(playerId: players.length > 1 ? players[1].id : '${team.id}_fw2', playerName: players.length > 1 ? players[1].name : 'Forvet 2', shirtNumber: players.length > 1 ? players[1].number : 9, x: 65, y: 50, hasBall: true, position: 'ST'),
      PlayerPosition(playerId: '${team.id}_fw3', playerName: 'Forvet 3', shirtNumber: 11, x: 60, y: 25, position: 'LW'),
    ];
  }

  /// Get initial player positions for away team (plays right to left)
  static List<PlayerPosition> getAwayFormationPositions(SimulationTeam team) {
    final players = team.players;
    return [
      // GK
      PlayerPosition(playerId: players[0].id, playerName: players[0].name, shirtNumber: players[0].number, x: 95, y: 50, position: 'GK'),
      // Defenders
      PlayerPosition(playerId: '${team.id}_def1', playerName: 'Savunma 1', shirtNumber: 2, x: 80, y: 20, position: 'RB'),
      PlayerPosition(playerId: '${team.id}_def2', playerName: 'Savunma 2', shirtNumber: 4, x: 80, y: 40, position: 'CB'),
      PlayerPosition(playerId: players.length > 4 ? players[4].id : '${team.id}_def3', playerName: players.length > 4 ? players[4].name : 'Savunma 3', shirtNumber: players.length > 4 ? players[4].number : 5, x: 80, y: 60, position: 'CB'),
      PlayerPosition(playerId: '${team.id}_def4', playerName: 'Savunma 4', shirtNumber: 3, x: 80, y: 80, position: 'LB'),
      // Midfielders
      PlayerPosition(playerId: players.length > 3 ? players[3].id : '${team.id}_mid1', playerName: players.length > 3 ? players[3].name : 'Orta Saha 1', shirtNumber: players.length > 3 ? players[3].number : 6, x: 60, y: 30, position: 'CM'),
      PlayerPosition(playerId: '${team.id}_mid2', playerName: 'Orta Saha 2', shirtNumber: 8, x: 60, y: 50, position: 'CM'),
      PlayerPosition(playerId: '${team.id}_mid3', playerName: 'Orta Saha 3', shirtNumber: 10, x: 60, y: 70, position: 'CM'),
      // Forwards
      PlayerPosition(playerId: '${team.id}_fw1', playerName: 'Forvet 1', shirtNumber: 7, x: 40, y: 25, position: 'RW'),
      PlayerPosition(playerId: players.length > 1 ? players[1].id : '${team.id}_fw2', playerName: players.length > 1 ? players[1].name : 'Forvet 2', shirtNumber: players.length > 1 ? players[1].number : 9, x: 35, y: 50, position: 'ST'),
      PlayerPosition(playerId: '${team.id}_fw3', playerName: 'Forvet 3', shirtNumber: 11, x: 40, y: 75, position: 'LW'),
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
