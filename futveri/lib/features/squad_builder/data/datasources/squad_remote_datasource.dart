import '../models/player_dto.dart';
import '../models/squad_dto.dart';
import '../../domain/entities/position.dart';

/// Remote data source for squad builder (Mock implementation)
/// TODO: Replace with Firebase implementation
class SquadRemoteDataSource {
  /// Get all available players
  Future<List<PlayerDto>> getAvailablePlayers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _mockPlayers;
  }

  /// Search players
  Future<List<PlayerDto>> searchPlayers({
    String? query,
    Position? position,
    int? minRating,
    int? maxRating,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    var players = _mockPlayers;
    
    // Filter by query
    if (query != null && query.isNotEmpty) {
      players = players
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    
    // Filter by position
    if (position != null) {
      players = players
          .where((p) =>
              p.primaryPosition.toLowerCase() == position.code.toLowerCase() ||
              p.alternativePositions
                  .any((alt) => alt.toLowerCase() == position.code.toLowerCase()))
          .toList();
    }
    
    // Filter by rating
    if (minRating != null || maxRating != null) {
      players = players.where((p) {
        final player = p.toEntity();
        final rating = player.overallRating;
        
        if (minRating != null && rating < minRating) return false;
        if (maxRating != null && rating > maxRating) return false;
        
        return true;
      }).toList();
    }
    
    return players;
  }

  /// Save squad to remote
  Future<void> saveSquad(SquadDto squad, String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Implement Firebase save
  }

  /// Load squad from remote
  Future<SquadDto?> loadSquad(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Implement Firebase load
    return null;
  }

  /// Mock players data
  static final List<PlayerDto> _mockPlayers = [
    // Premier League - Elite Players
    PlayerDto(
      id: '1',
      name: 'Erling Haaland',
      nationality: '🇳🇴 Norway',
      primaryPosition: 'ST',
      alternativePositions: ['CF'],
      preferredFoot: 'left',
      pace: 89,
      shooting: 94,
      passing: 65,
      dribbling: 80,
      defending: 45,
      physical: 88,
      age: 23,
      club: 'Manchester City',
      jerseyNumber: 9,
    ),
    PlayerDto(
      id: '2',
      name: 'Kevin De Bruyne',
      nationality: '🇧🇪 Belgium',
      primaryPosition: 'CAM',
      alternativePositions: ['CM', 'RM'],
      preferredFoot: 'right',
      pace: 76,
      shooting: 86,
      passing: 93,
      dribbling: 88,
      defending: 64,
      physical: 78,
      age: 32,
      club: 'Manchester City',
      jerseyNumber: 17,
    ),
    PlayerDto(
      id: '3',
      name: 'Mohamed Salah',
      nationality: '🇪🇬 Egypt',
      primaryPosition: 'RW',
      alternativePositions: ['ST', 'RM'],
      preferredFoot: 'left',
      pace: 90,
      shooting: 87,
      passing: 81,
      dribbling: 90,
      defending: 45,
      physical: 75,
      age: 31,
      club: 'Liverpool',
      jerseyNumber: 11,
    ),
    PlayerDto(
      id: '4',
      name: 'Virgil van Dijk',
      nationality: '🇳🇱 Netherlands',
      primaryPosition: 'CB',
      alternativePositions: [],
      preferredFoot: 'right',
      pace: 77,
      shooting: 60,
      passing: 71,
      dribbling: 72,
      defending: 91,
      physical: 86,
      age: 32,
      club: 'Liverpool',
      jerseyNumber: 4,
    ),
    PlayerDto(
      id: '5',
      name: 'Bukayo Saka',
      nationality: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 England',
      primaryPosition: 'RW',
      alternativePositions: ['RM', 'RB'],
      preferredFoot: 'left',
      pace: 86,
      shooting: 79,
      passing: 81,
      dribbling: 86,
      defending: 52,
      physical: 70,
      age: 22,
      club: 'Arsenal',
      jerseyNumber: 7,
    ),
    
    // La Liga
    PlayerDto(
      id: '6',
      name: 'Vinícius Júnior',
      nationality: '🇧🇷 Brazil',
      primaryPosition: 'LW',
      alternativePositions: ['ST'],
      preferredFoot: 'right',
      pace: 95,
      shooting: 83,
      passing: 78,
      dribbling: 90,
      defending: 29,
      physical: 61,
      age: 23,
      club: 'Real Madrid',
      jerseyNumber: 7,
    ),
    PlayerDto(
      id: '7',
      name: 'Jude Bellingham',
      nationality: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 England',
      primaryPosition: 'CM',
      alternativePositions: ['CAM', 'CDM'],
      preferredFoot: 'right',
      pace: 78,
      shooting: 82,
      passing: 83,
      dribbling: 84,
      defending: 78,
      physical: 84,
      age: 20,
      club: 'Real Madrid',
      jerseyNumber: 5,
    ),
    PlayerDto(
      id: '8',
      name: 'Robert Lewandowski',
      nationality: '🇵🇱 Poland',
      primaryPosition: 'ST',
      alternativePositions: ['CF'],
      preferredFoot: 'right',
      pace: 78,
      shooting: 91,
      passing: 79,
      dribbling: 86,
      defending: 44,
      physical: 82,
      age: 35,
      club: 'Barcelona',
      jerseyNumber: 9,
    ),
    PlayerDto(
      id: '9',
      name: 'Pedri',
      nationality: '🇪🇸 Spain',
      primaryPosition: 'CM',
      alternativePositions: ['CAM'],
      preferredFoot: 'right',
      pace: 68,
      shooting: 70,
      passing: 86,
      dribbling: 85,
      defending: 59,
      physical: 63,
      age: 21,
      club: 'Barcelona',
      jerseyNumber: 8,
    ),
    
    // Bundesliga
    PlayerDto(
      id: '10',
      name: 'Harry Kane',
      nationality: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 England',
      primaryPosition: 'ST',
      alternativePositions: ['CF'],
      preferredFoot: 'right',
      pace: 70,
      shooting: 92,
      passing: 83,
      dribbling: 82,
      defending: 47,
      physical: 83,
      age: 30,
      club: 'Bayern Munich',
      jerseyNumber: 9,
    ),
    PlayerDto(
      id: '11',
      name: 'Jamal Musiala',
      nationality: '🇩🇪 Germany',
      primaryPosition: 'CAM',
      alternativePositions: ['CM', 'LW'],
      preferredFoot: 'right',
      pace: 80,
      shooting: 76,
      passing: 81,
      dribbling: 87,
      defending: 34,
      physical: 65,
      age: 20,
      club: 'Bayern Munich',
      jerseyNumber: 42,
    ),
    
    // Süper Lig
    PlayerDto(
      id: '12',
      name: 'Mauro Icardi',
      nationality: '🇦🇷 Argentina',
      primaryPosition: 'ST',
      alternativePositions: ['CF'],
      preferredFoot: 'right',
      pace: 78,
      shooting: 85,
      passing: 72,
      dribbling: 79,
      defending: 38,
      physical: 80,
      age: 30,
      club: 'Galatasaray',
      jerseyNumber: 9,
    ),
    PlayerDto(
      id: '13',
      name: 'Edin Džeko',
      nationality: '🇧🇦 Bosnia',
      primaryPosition: 'ST',
      alternativePositions: ['CF'],
      preferredFoot: 'both',
      pace: 68,
      shooting: 83,
      passing: 75,
      dribbling: 76,
      defending: 42,
      physical: 84,
      age: 37,
      club: 'Fenerbahçe',
      jerseyNumber: 9,
    ),
    
    // Midfielders
    PlayerDto(
      id: '14',
      name: 'Rodri',
      nationality: '🇪🇸 Spain',
      primaryPosition: 'CDM',
      alternativePositions: ['CM'],
      preferredFoot: 'right',
      pace: 62,
      shooting: 72,
      passing: 87,
      dribbling: 78,
      defending: 87,
      physical: 84,
      age: 27,
      club: 'Manchester City',
      jerseyNumber: 16,
    ),
    PlayerDto(
      id: '15',
      name: 'Bruno Fernandes',
      nationality: '🇵🇹 Portugal',
      primaryPosition: 'CAM',
      alternativePositions: ['CM'],
      preferredFoot: 'right',
      pace: 75,
      shooting: 84,
      passing: 89,
      dribbling: 84,
      defending: 69,
      physical: 77,
      age: 29,
      club: 'Manchester United',
      jerseyNumber: 8,
    ),
    
    // Defenders
    PlayerDto(
      id: '16',
      name: 'Rúben Dias',
      nationality: '🇵🇹 Portugal',
      primaryPosition: 'CB',
      alternativePositions: [],
      preferredFoot: 'right',
      pace: 62,
      shooting: 50,
      passing: 72,
      dribbling: 70,
      defending: 88,
      physical: 83,
      age: 26,
      club: 'Manchester City',
      jerseyNumber: 3,
    ),
    PlayerDto(
      id: '17',
      name: 'Trent Alexander-Arnold',
      nationality: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 England',
      primaryPosition: 'RB',
      alternativePositions: ['RWB', 'RM'],
      preferredFoot: 'right',
      pace: 76,
      shooting: 72,
      passing: 89,
      dribbling: 81,
      defending: 76,
      physical: 71,
      age: 25,
      club: 'Liverpool',
      jerseyNumber: 66,
    ),
    PlayerDto(
      id: '18',
      name: 'Andrew Robertson',
      nationality: '🏴󠁧󠁢󠁳󠁣󠁴󠁿 Scotland',
      primaryPosition: 'LB',
      alternativePositions: ['LWB'],
      preferredFoot: 'left',
      pace: 83,
      shooting: 59,
      passing: 81,
      dribbling: 79,
      defending: 82,
      physical: 77,
      age: 29,
      club: 'Liverpool',
      jerseyNumber: 26,
    ),
    PlayerDto(
      id: '19',
      name: 'William Saliba',
      nationality: '🇫🇷 France',
      primaryPosition: 'CB',
      alternativePositions: [],
      preferredFoot: 'right',
      pace: 77,
      shooting: 42,
      passing: 73,
      dribbling: 71,
      defending: 84,
      physical: 80,
      age: 22,
      club: 'Arsenal',
      jerseyNumber: 2,
    ),
    PlayerDto(
      id: '20',
      name: 'Alphonso Davies',
      nationality: '🇨🇦 Canada',
      primaryPosition: 'LB',
      alternativePositions: ['LWB', 'LM'],
      preferredFoot: 'left',
      pace: 96,
      shooting: 68,
      passing: 77,
      dribbling: 82,
      defending: 76,
      physical: 77,
      age: 23,
      club: 'Bayern Munich',
      jerseyNumber: 19,
    ),
    
    // Goalkeepers
    PlayerDto(
      id: '21',
      name: 'Alisson Becker',
      nationality: '🇧🇷 Brazil',
      primaryPosition: 'GK',
      alternativePositions: [],
      preferredFoot: 'right',
      pace: 51,
      shooting: 13,
      passing: 75,
      dribbling: 48,
      defending: 90,
      physical: 90,
      age: 31,
      club: 'Liverpool',
      jerseyNumber: 1,
    ),
    PlayerDto(
      id: '22',
      name: 'Ederson',
      nationality: '🇧🇷 Brazil',
      primaryPosition: 'GK',
      alternativePositions: [],
      preferredFoot: 'left',
      pace: 62,
      shooting: 11,
      passing: 93,
      dribbling: 88,
      defending: 88,
      physical: 86,
      age: 30,
      club: 'Manchester City',
      jerseyNumber: 31,
    ),
    PlayerDto(
      id: '23',
      name: 'Marc-André ter Stegen',
      nationality: '🇩🇪 Germany',
      primaryPosition: 'GK',
      alternativePositions: [],
      preferredFoot: 'right',
      pace: 50,
      shooting: 11,
      passing: 88,
      dribbling: 50,
      defending: 89,
      physical: 87,
      age: 31,
      club: 'Barcelona',
      jerseyNumber: 1,
    ),
    
    // More wingers and attackers
    PlayerDto(
      id: '24',
      name: 'Kylian Mbappé',
      nationality: '🇫🇷 France',
      primaryPosition: 'ST',
      alternativePositions: ['LW', 'RW'],
      preferredFoot: 'right',
      pace: 97,
      shooting: 89,
      passing: 80,
      dribbling: 92,
      defending: 36,
      physical: 77,
      age: 25,
      club: 'Real Madrid',
      jerseyNumber: 9,
    ),
    PlayerDto(
      id: '25',
      name: 'Phil Foden',
      nationality: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 England',
      primaryPosition: 'LW',
      alternativePositions: ['CAM', 'CM'],
      preferredFoot: 'left',
      pace: 85,
      shooting: 80,
      passing: 83,
      dribbling: 89,
      defending: 56,
      physical: 61,
      age: 23,
      club: 'Manchester City',
      jerseyNumber: 47,
    ),
  ];
}
