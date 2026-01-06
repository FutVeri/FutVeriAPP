import 'simulation_models.dart';

class MockSimulationData {
  static List<SimulationTeam> get teams => [
    galatasaray,
    fenerbahce,
    besiktas,
    trabzonspor,
  ];

  static SimulationTeam get galatasaray => const SimulationTeam(
    id: 'gs',
    name: 'Galatasaray',
    shortName: 'GS',
    logoUrl: 'assets/teams/gs.png',
    formation: '4-2-3-1',
    overallRating: 84.5,
    recentForm: ['W', 'W', 'D', 'W', 'L'],
    strengths: TeamStrengths(
      attack: 88,
      midfield: 85,
      defense: 82,
      setPieces: 86,
      strongPoints: ['Kontra atak', 'Kanat oyunu', 'Hava topu'],
      weakPoints: ['Yüksek defans çizgisi', 'Geçiş anları'],
    ),
    players: [
      SimulationPlayer(
        id: 'gs1',
        name: 'Fernando Muslera',
        position: 'GK',
        number: 1,
        rating: 82.0,
        threatLevel: 15,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 45, shooting: 20, passing: 65, dribbling: 40, defending: 25, physical: 70),
      ),
      SimulationPlayer(
        id: 'gs2',
        name: 'Victor Osimhen',
        position: 'ST',
        number: 45,
        rating: 88.0,
        threatLevel: 95,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 90, shooting: 88, passing: 65, dribbling: 80, defending: 35, physical: 85),
      ),
      SimulationPlayer(
        id: 'gs3',
        name: 'Dries Mertens',
        position: 'CAM',
        number: 10,
        rating: 83.0,
        threatLevel: 80,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 78, shooting: 85, passing: 84, dribbling: 86, defending: 30, physical: 55),
      ),
      SimulationPlayer(
        id: 'gs4',
        name: 'Lucas Torreira',
        position: 'CDM',
        number: 34,
        rating: 82.0,
        threatLevel: 45,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 68, shooting: 62, passing: 78, dribbling: 75, defending: 82, physical: 72),
      ),
      SimulationPlayer(
        id: 'gs5',
        name: 'Davinson Sánchez',
        position: 'CB',
        number: 6,
        rating: 81.0,
        threatLevel: 30,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 78, shooting: 35, passing: 55, dribbling: 50, defending: 84, physical: 85),
      ),
    ],
  );

  static SimulationTeam get fenerbahce => const SimulationTeam(
    id: 'fb',
    name: 'Fenerbahçe',
    shortName: 'FB',
    logoUrl: 'assets/teams/fb.png',
    formation: '4-3-3',
    overallRating: 83.8,
    recentForm: ['W', 'W', 'W', 'D', 'W'],
    strengths: TeamStrengths(
      attack: 86,
      midfield: 84,
      defense: 83,
      setPieces: 82,
      strongPoints: ['Topa sahip olma', 'Orta saha baskısı', 'Kanat değiştirme'],
      weakPoints: ['Hızlı kontra ataklara açık', 'Sol kanat savunması'],
    ),
    players: [
      SimulationPlayer(
        id: 'fb1',
        name: 'Dominik Livakovic',
        position: 'GK',
        number: 1,
        rating: 84.0,
        threatLevel: 10,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 48, shooting: 15, passing: 62, dribbling: 38, defending: 20, physical: 75),
      ),
      SimulationPlayer(
        id: 'fb2',
        name: 'Edin Dzeko',
        position: 'ST',
        number: 9,
        rating: 82.0,
        threatLevel: 85,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 62, shooting: 86, passing: 72, dribbling: 75, defending: 40, physical: 88),
      ),
      SimulationPlayer(
        id: 'fb3',
        name: 'Dusan Tadic',
        position: 'LW',
        number: 10,
        rating: 83.0,
        threatLevel: 78,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 72, shooting: 80, passing: 85, dribbling: 84, defending: 35, physical: 65),
      ),
      SimulationPlayer(
        id: 'fb4',
        name: 'Fred',
        position: 'CM',
        number: 17,
        rating: 81.0,
        threatLevel: 50,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 75, shooting: 65, passing: 78, dribbling: 76, defending: 78, physical: 80),
      ),
      SimulationPlayer(
        id: 'fb5',
        name: 'Alexander Djiku',
        position: 'CB',
        number: 4,
        rating: 80.0,
        threatLevel: 25,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 75, shooting: 30, passing: 58, dribbling: 52, defending: 82, physical: 84),
      ),
    ],
  );

  static SimulationTeam get besiktas => const SimulationTeam(
    id: 'bjk',
    name: 'Beşiktaş',
    shortName: 'BJK',
    logoUrl: 'assets/teams/bjk.png',
    formation: '4-4-2',
    overallRating: 81.2,
    recentForm: ['D', 'W', 'L', 'W', 'W'],
    strengths: TeamStrengths(
      attack: 82,
      midfield: 80,
      defense: 79,
      setPieces: 78,
      strongPoints: ['Genç oyuncular', 'Enerji ve tempo', 'Presing'],
      weakPoints: ['Tecrübe eksikliği', 'Maç yönetimi'],
    ),
    players: [
      SimulationPlayer(
        id: 'bjk1',
        name: 'Mert Günok',
        position: 'GK',
        number: 1,
        rating: 82.0,
        threatLevel: 12,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 42, shooting: 18, passing: 58, dribbling: 35, defending: 22, physical: 72),
      ),
      SimulationPlayer(
        id: 'bjk2',
        name: 'Ciro Immobile',
        position: 'ST',
        number: 17,
        rating: 83.0,
        threatLevel: 88,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 80, shooting: 88, passing: 65, dribbling: 78, defending: 30, physical: 72),
      ),
      SimulationPlayer(
        id: 'bjk3',
        name: 'Rafa Silva',
        position: 'RW',
        number: 10,
        rating: 82.0,
        threatLevel: 75,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 88, shooting: 78, passing: 80, dribbling: 86, defending: 28, physical: 55),
      ),
      SimulationPlayer(
        id: 'bjk4',
        name: 'Gedson Fernandes',
        position: 'CM',
        number: 8,
        rating: 79.0,
        threatLevel: 45,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 78, shooting: 68, passing: 75, dribbling: 76, defending: 72, physical: 78),
      ),
      SimulationPlayer(
        id: 'bjk5',
        name: 'Gabriel Paulista',
        position: 'CB',
        number: 5,
        rating: 80.0,
        threatLevel: 28,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 72, shooting: 32, passing: 52, dribbling: 48, defending: 83, physical: 82),
      ),
    ],
  );

  static SimulationTeam get trabzonspor => const SimulationTeam(
    id: 'ts',
    name: 'Trabzonspor',
    shortName: 'TS',
    logoUrl: 'assets/teams/ts.png',
    formation: '3-5-2',
    overallRating: 79.5,
    recentForm: ['L', 'D', 'W', 'L', 'D'],
    strengths: TeamStrengths(
      attack: 80,
      midfield: 78,
      defense: 77,
      setPieces: 80,
      strongPoints: ['Taraftar desteği', 'Duran toplar', 'Fiziksel güç'],
      weakPoints: ['Deplasman performansı', 'Bireysel hatalar'],
    ),
    players: [
      SimulationPlayer(
        id: 'ts1',
        name: 'Uğurcan Çakır',
        position: 'GK',
        number: 1,
        rating: 83.0,
        threatLevel: 10,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 45, shooting: 16, passing: 60, dribbling: 38, defending: 20, physical: 78),
      ),
      SimulationPlayer(
        id: 'ts2',
        name: 'Enis Bardhi',
        position: 'CAM',
        number: 10,
        rating: 79.0,
        threatLevel: 70,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 72, shooting: 78, passing: 82, dribbling: 80, defending: 35, physical: 62),
      ),
      SimulationPlayer(
        id: 'ts3',
        name: 'Paul Onuachu',
        position: 'ST',
        number: 9,
        rating: 78.0,
        threatLevel: 75,
        isKeyPlayer: true,
        attributes: PlayerAttributes(pace: 68, shooting: 82, passing: 55, dribbling: 65, defending: 30, physical: 92),
      ),
      SimulationPlayer(
        id: 'ts4',
        name: 'Okay Yokuşlu',
        position: 'CDM',
        number: 6,
        rating: 78.0,
        threatLevel: 35,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 65, shooting: 55, passing: 72, dribbling: 68, defending: 80, physical: 82),
      ),
      SimulationPlayer(
        id: 'ts5',
        name: 'Stefano Denswil',
        position: 'CB',
        number: 4,
        rating: 76.0,
        threatLevel: 20,
        isKeyPlayer: false,
        attributes: PlayerAttributes(pace: 70, shooting: 35, passing: 62, dribbling: 55, defending: 78, physical: 80),
      ),
    ],
  );

  static List<TacticalSuggestion> getTacticalSuggestions(SimulationTeam homeTeam, SimulationTeam awayTeam) {
    return [
      TacticalSuggestion(
        title: 'Kanat Baskısı Uygula',
        description: '${awayTeam.shortName} sol kanat savunmasında zayıf. Sağ kanattan sürekli atak geliştir.',
        priority: 'high',
        category: 'attack',
      ),
      TacticalSuggestion(
        title: 'Orta Sahada Kompakt Kal',
        description: '${awayTeam.shortName} orta saha kontrolüne önem veriyor. Aralarındaki boşlukları kapat.',
        priority: 'high',
        category: 'midfield',
      ),
      TacticalSuggestion(
        title: 'Kontra Atak Fırsatlarını Değerlendir',
        description: '${awayTeam.shortName} yüksek defans çizgisi tutuyor. Arkaya atılan toplara dikkat et.',
        priority: 'medium',
        category: 'attack',
      ),
      TacticalSuggestion(
        title: 'Duran Toplara Dikkat',
        description: '${awayTeam.shortName} duran toplarda tehlikeli. Yakın adam markajı uygula.',
        priority: 'medium',
        category: 'defense',
      ),
      TacticalSuggestion(
        title: 'Anahtar Oyuncuyu İzole Et',
        description: 'Rakibin 10 numarasına çift adam markaj uygula ve oyun kurmasını engelle.',
        priority: 'high',
        category: 'defense',
      ),
    ];
  }

  static MatchAnalysis analyzeMatch(SimulationTeam homeTeam, SimulationTeam awayTeam) {
    // Simple probability calculation based on ratings
    final ratingDiff = homeTeam.overallRating - awayTeam.overallRating;
    final homeAdvantage = 5.0; // Home advantage bonus
    
    double homeWin = 35 + (ratingDiff + homeAdvantage) * 2;
    double draw = 25 - (ratingDiff.abs() * 0.5);
    double awayWin = 100 - homeWin - draw;
    
    // Clamp values
    homeWin = homeWin.clamp(10, 80);
    draw = draw.clamp(15, 35);
    awayWin = (100 - homeWin - draw).clamp(10, 80);
    
    // Normalize to 100
    final total = homeWin + draw + awayWin;
    homeWin = (homeWin / total) * 100;
    draw = (draw / total) * 100;
    awayWin = (awayWin / total) * 100;

    return MatchAnalysis(
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      homeWinProbability: homeWin,
      drawProbability: draw,
      awayWinProbability: awayWin,
      suggestions: getTacticalSuggestions(homeTeam, awayTeam),
      keyMatchups: _generateKeyMatchups(homeTeam, awayTeam),
    );
  }

  static List<KeyMatchup> _generateKeyMatchups(SimulationTeam home, SimulationTeam away) {
    final homeKeyPlayers = home.players.where((p) => p.isKeyPlayer).toList();
    final awayKeyPlayers = away.players.where((p) => p.isKeyPlayer).toList();
    
    List<KeyMatchup> matchups = [];
    
    if (homeKeyPlayers.isNotEmpty && awayKeyPlayers.isNotEmpty) {
      matchups.add(KeyMatchup(
        player1: homeKeyPlayers.first,
        player2: awayKeyPlayers.first,
        description: 'Kritik ikili mücadele',
        advantageScore: (homeKeyPlayers.first.rating - awayKeyPlayers.first.rating) * 10,
      ));
    }
    
    return matchups;
  }
}
