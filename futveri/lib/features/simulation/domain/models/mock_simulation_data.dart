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
      SimulationPlayer(id: 'gs1', name: 'Fernando Muslera', position: 'GK', number: 1, rating: 82.0, threatLevel: 15, isKeyPlayer: false, attributes: PlayerAttributes(pace: 45, shooting: 20, passing: 65, dribbling: 40, defending: 25, physical: 70)),
      SimulationPlayer(id: 'gs2', name: 'Victor Osimhen', position: 'ST', number: 45, rating: 88.0, threatLevel: 95, isKeyPlayer: true, attributes: PlayerAttributes(pace: 90, shooting: 88, passing: 65, dribbling: 80, defending: 35, physical: 85)),
      SimulationPlayer(id: 'gs3', name: 'Dries Mertens', position: 'CAM', number: 10, rating: 83.0, threatLevel: 80, isKeyPlayer: true, attributes: PlayerAttributes(pace: 78, shooting: 85, passing: 84, dribbling: 86, defending: 30, physical: 55)),
      SimulationPlayer(id: 'gs4', name: 'Lucas Torreira', position: 'CDM', number: 34, rating: 82.0, threatLevel: 45, isKeyPlayer: false, attributes: PlayerAttributes(pace: 68, shooting: 62, passing: 78, dribbling: 75, defending: 82, physical: 72)),
      SimulationPlayer(id: 'gs5', name: 'Davinson Sánchez', position: 'CB', number: 6, rating: 81.0, threatLevel: 30, isKeyPlayer: false, attributes: PlayerAttributes(pace: 78, shooting: 35, passing: 55, dribbling: 50, defending: 84, physical: 85)),
      SimulationPlayer(id: 'gs6', name: 'Abdülkerim Bardakcı', position: 'CB', number: 42, rating: 80.0, threatLevel: 35, isKeyPlayer: false, attributes: PlayerAttributes(pace: 70, shooting: 55, passing: 72, dribbling: 60, defending: 82, physical: 86)),
      SimulationPlayer(id: 'gs7', name: 'Barış Alper Yılmaz', position: 'RW', number: 53, rating: 81.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 92, shooting: 78, passing: 70, dribbling: 82, defending: 65, physical: 88)),
      SimulationPlayer(id: 'gs8', name: 'Gabriel Sara', position: 'CM', number: 20, rating: 82.0, threatLevel: 65, isKeyPlayer: false, attributes: PlayerAttributes(pace: 75, shooting: 80, passing: 85, dribbling: 82, defending: 70, physical: 75)),
      SimulationPlayer(id: 'gs9', name: 'Kaan Ayhan', position: 'RB', number: 22, rating: 78.0, threatLevel: 30, isKeyPlayer: false, attributes: PlayerAttributes(pace: 70, shooting: 65, passing: 78, dribbling: 70, defending: 80, physical: 82)),
      SimulationPlayer(id: 'gs10', name: 'Ismail Jakobs', position: 'LB', number: 4, rating: 77.0, threatLevel: 40, isKeyPlayer: false, attributes: PlayerAttributes(pace: 88, shooting: 55, passing: 70, dribbling: 75, defending: 76, physical: 78)),
      SimulationPlayer(id: 'gs11', name: 'Yunus Akgün', position: 'LW', number: 7, rating: 78.0, threatLevel: 70, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 75, passing: 78, dribbling: 84, defending: 45, physical: 65)),
      // Bench
      SimulationPlayer(id: 'gs12', name: 'Günay Güvenç', position: 'GK', number: 19, rating: 75.0, threatLevel: 5, isKeyPlayer: false, attributes: PlayerAttributes(pace: 40, shooting: 15, passing: 60, dribbling: 35, defending: 20, physical: 70)),
      SimulationPlayer(id: 'gs13', name: 'Mauro Icardi', position: 'ST', number: 9, rating: 86.0, threatLevel: 90, isKeyPlayer: true, attributes: PlayerAttributes(pace: 75, shooting: 92, passing: 75, dribbling: 80, defending: 35, physical: 78)),
      SimulationPlayer(id: 'gs14', name: 'Michy Batshuayi', position: 'ST', number: 44, rating: 79.0, threatLevel: 80, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 80, passing: 65, dribbling: 78, defending: 30, physical: 82)),
      SimulationPlayer(id: 'gs15', name: 'Kerem Demirbay', position: 'CM', number: 8, rating: 78.0, threatLevel: 60, isKeyPlayer: false, attributes: PlayerAttributes(pace: 65, shooting: 78, passing: 82, dribbling: 76, defending: 68, physical: 72)),
      SimulationPlayer(id: 'gs16', name: 'Victor Nelsson', position: 'CB', number: 25, rating: 79.0, threatLevel: 25, isKeyPlayer: false, attributes: PlayerAttributes(pace: 68, shooting: 30, passing: 60, dribbling: 50, defending: 82, physical: 84)),
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
      attack: 86, midfield: 84, defense: 83, setPieces: 82,
      strongPoints: ['Topa sahip olma', 'Orta saha baskısı', 'Kanat değiştirme'],
      weakPoints: ['Hızlı kontra ataklara açık', 'Sol kanat savunması'],
    ),
    players: [
      SimulationPlayer(id: 'fb1', name: 'Dominik Livakovic', position: 'GK', number: 1, rating: 84.0, threatLevel: 10, isKeyPlayer: false, attributes: PlayerAttributes(pace: 48, shooting: 15, passing: 62, dribbling: 38, defending: 20, physical: 75)),
      SimulationPlayer(id: 'fb2', name: 'Edin Dzeko', position: 'ST', number: 9, rating: 82.0, threatLevel: 85, isKeyPlayer: true, attributes: PlayerAttributes(pace: 62, shooting: 86, passing: 72, dribbling: 75, defending: 40, physical: 88)),
      SimulationPlayer(id: 'fb3', name: 'Dusan Tadic', position: 'LW', number: 10, rating: 83.0, threatLevel: 78, isKeyPlayer: true, attributes: PlayerAttributes(pace: 72, shooting: 80, passing: 85, dribbling: 84, defending: 35, physical: 65)),
      SimulationPlayer(id: 'fb4', name: 'Fred', position: 'CM', number: 17, rating: 81.0, threatLevel: 50, isKeyPlayer: false, attributes: PlayerAttributes(pace: 75, shooting: 65, passing: 78, dribbling: 76, defending: 78, physical: 80)),
      SimulationPlayer(id: 'fb5', name: 'Alexander Djiku', position: 'CB', number: 4, rating: 80.0, threatLevel: 25, isKeyPlayer: false, attributes: PlayerAttributes(pace: 75, shooting: 30, passing: 58, dribbling: 52, defending: 82, physical: 84)),
      SimulationPlayer(id: 'fb6', name: 'Çağlar Söyüncü', position: 'CB', number: 2, rating: 81.0, threatLevel: 30, isKeyPlayer: false, attributes: PlayerAttributes(pace: 74, shooting: 45, passing: 60, dribbling: 55, defending: 83, physical: 85)),
      SimulationPlayer(id: 'fb7', name: 'Mert Müldür', position: 'RB', number: 16, rating: 77.0, threatLevel: 45, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 60, passing: 72, dribbling: 75, defending: 76, physical: 74)),
      SimulationPlayer(id: 'fb8', name: 'Jayden Oosterwolde', position: 'LB', number: 24, rating: 78.0, threatLevel: 55, isKeyPlayer: false, attributes: PlayerAttributes(pace: 88, shooting: 65, passing: 68, dribbling: 76, defending: 78, physical: 84)),
      SimulationPlayer(id: 'fb9', name: 'Sofyan Amrabat', position: 'CDM', number: 5, rating: 81.0, threatLevel: 40, isKeyPlayer: false, attributes: PlayerAttributes(pace: 70, shooting: 60, passing: 80, dribbling: 75, defending: 82, physical: 88)),
      SimulationPlayer(id: 'fb10', name: 'Sebastian Szymański', position: 'CAM', number: 53, rating: 82.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 84, shooting: 78, passing: 83, dribbling: 82, defending: 60, physical: 68)),
      SimulationPlayer(id: 'fb11', name: 'Allan Saint-Maximin', position: 'RW', number: 97, rating: 83.0, threatLevel: 85, isKeyPlayer: true, attributes: PlayerAttributes(pace: 93, shooting: 75, passing: 78, dribbling: 92, defending: 35, physical: 74)),
      // Bench
      SimulationPlayer(id: 'fb12', name: 'Irfan Can Egribayat', position: 'GK', number: 40, rating: 74.0, threatLevel: 5, isKeyPlayer: false, attributes: PlayerAttributes(pace: 45, shooting: 15, passing: 55, dribbling: 35, defending: 20, physical: 72)),
      SimulationPlayer(id: 'fb13', name: 'Youssef En-Nesyri', position: 'ST', number: 19, rating: 82.0, threatLevel: 85, isKeyPlayer: false, attributes: PlayerAttributes(pace: 86, shooting: 82, passing: 60, dribbling: 74, defending: 45, physical: 84)),
      SimulationPlayer(id: 'fb14', name: 'Irfan Can Kahveci', position: 'RW', number: 17, rating: 81.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 72, shooting: 84, passing: 86, dribbling: 84, defending: 55, physical: 70)),
      SimulationPlayer(id: 'fb15', name: 'Filip Kostić', position: 'LW', number: 18, rating: 80.0, threatLevel: 70, isKeyPlayer: false, attributes: PlayerAttributes(pace: 84, shooting: 75, passing: 88, dribbling: 80, defending: 65, physical: 78)),
      SimulationPlayer(id: 'fb16', name: 'Cengiz Ünder', position: 'RW', number: 15, rating: 79.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 82, passing: 78, dribbling: 84, defending: 40, physical: 65)),
    ],
  );

  static SimulationTeam get besiktas => const SimulationTeam(
    id: 'bjk',
    name: 'Beşiktaş',
    shortName: 'BJK',
    logoUrl: 'assets/teams/bjk.png',
    formation: '4-2-3-1',
    overallRating: 81.2,
    recentForm: ['D', 'W', 'L', 'W', 'W'],
    strengths: TeamStrengths(
      attack: 82, midfield: 80, defense: 79, setPieces: 78,
      strongPoints: ['Genç oyuncular', 'Enerji ve tempo', 'Presing'],
      weakPoints: ['Tecrübe eksikliği', 'Maç yönetimi'],
    ),
    players: [
      SimulationPlayer(id: 'bjk1', name: 'Mert Günok', position: 'GK', number: 1, rating: 82.0, threatLevel: 12, isKeyPlayer: false, attributes: PlayerAttributes(pace: 42, shooting: 18, passing: 58, dribbling: 35, defending: 22, physical: 72)),
      SimulationPlayer(id: 'bjk2', name: 'Ciro Immobile', position: 'ST', number: 17, rating: 83.0, threatLevel: 88, isKeyPlayer: true, attributes: PlayerAttributes(pace: 80, shooting: 88, passing: 65, dribbling: 78, defending: 30, physical: 72)),
      SimulationPlayer(id: 'bjk3', name: 'Rafa Silva', position: 'CAM', number: 27, rating: 84.0, threatLevel: 85, isKeyPlayer: true, attributes: PlayerAttributes(pace: 88, shooting: 78, passing: 85, dribbling: 90, defending: 28, physical: 55)),
      SimulationPlayer(id: 'bjk4', name: 'Gedson Fernandes', position: 'CM', number: 8, rating: 81.0, threatLevel: 65, isKeyPlayer: false, attributes: PlayerAttributes(pace: 84, shooting: 72, passing: 78, dribbling: 82, defending: 78, physical: 85)),
      SimulationPlayer(id: 'bjk5', name: 'Gabriel Paulista', position: 'CB', number: 5, rating: 80.0, threatLevel: 28, isKeyPlayer: false, attributes: PlayerAttributes(pace: 72, shooting: 32, passing: 52, dribbling: 48, defending: 83, physical: 82)),
      SimulationPlayer(id: 'bjk6', name: 'Felix Uduokhai', position: 'CB', number: 14, rating: 78.0, threatLevel: 25, isKeyPlayer: false, attributes: PlayerAttributes(pace: 74, shooting: 35, passing: 65, dribbling: 55, defending: 80, physical: 84)),
      SimulationPlayer(id: 'bjk7', name: 'Jonas Svensson', position: 'RB', number: 2, rating: 77.0, threatLevel: 40, isKeyPlayer: false, attributes: PlayerAttributes(pace: 78, shooting: 55, passing: 72, dribbling: 74, defending: 76, physical: 75)),
      SimulationPlayer(id: 'bjk8', name: 'Arthur Masuaku', position: 'LB', number: 26, rating: 78.0, threatLevel: 55, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 68, passing: 80, dribbling: 84, defending: 74, physical: 76)),
      SimulationPlayer(id: 'bjk9', name: 'Al-Musrati', position: 'CDM', number: 6, rating: 80.0, threatLevel: 40, isKeyPlayer: false, attributes: PlayerAttributes(pace: 60, shooting: 70, passing: 84, dribbling: 75, defending: 82, physical: 86)),
      SimulationPlayer(id: 'bjk10', name: 'Milot Rashica', position: 'RW', number: 7, rating: 79.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 86, shooting: 76, passing: 75, dribbling: 82, defending: 55, physical: 72)),
      SimulationPlayer(id: 'bjk11', name: 'Ernest Muçi', position: 'LW', number: 10, rating: 78.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 80, shooting: 82, passing: 78, dribbling: 84, defending: 35, physical: 65)),
      // Bench
      SimulationPlayer(id: 'bjk12', name: 'Ersin Destanoğlu', position: 'GK', number: 30, rating: 75.0, threatLevel: 5, isKeyPlayer: false, attributes: PlayerAttributes(pace: 45, shooting: 15, passing: 65, dribbling: 40, defending: 20, physical: 75)),
      SimulationPlayer(id: 'bjk13', name: 'Semih Kılıçsoy', position: 'ST', number: 9, rating: 78.0, threatLevel: 80, isKeyPlayer: true, attributes: PlayerAttributes(pace: 82, shooting: 84, passing: 70, dribbling: 86, defending: 40, physical: 82)),
      SimulationPlayer(id: 'bjk14', name: 'Cher Ndour', position: 'CM', number: 73, rating: 75.0, threatLevel: 50, isKeyPlayer: false, attributes: PlayerAttributes(pace: 68, shooting: 70, passing: 80, dribbling: 75, defending: 65, physical: 78)),
      SimulationPlayer(id: 'bjk15', name: 'Mustafa Hekimoğlu', position: 'ST', number: 91, rating: 72.0, threatLevel: 70, isKeyPlayer: false, attributes: PlayerAttributes(pace: 84, shooting: 75, passing: 65, dribbling: 78, defending: 30, physical: 72)),
      SimulationPlayer(id: 'bjk16', name: 'Emirhan Topçu', position: 'CB', number: 53, rating: 76.0, threatLevel: 30, isKeyPlayer: false, attributes: PlayerAttributes(pace: 70, shooting: 40, passing: 68, dribbling: 60, defending: 78, physical: 80)),
    ],
  );

  static SimulationTeam get trabzonspor => const SimulationTeam(
    id: 'ts',
    name: 'Trabzonspor',
    shortName: 'TS',
    logoUrl: 'assets/teams/ts.png',
    formation: '4-3-3',
    overallRating: 79.5,
    recentForm: ['L', 'D', 'W', 'L', 'D'],
    strengths: TeamStrengths(
      attack: 80, midfield: 78, defense: 77, setPieces: 80,
      strongPoints: ['Taraftar desteği', 'Duran toplar', 'Fiziksel güç'],
      weakPoints: ['Deplasman performansı', 'Bireysel hatalar'],
    ),
    players: [
      SimulationPlayer(id: 'ts1', name: 'Uğurcan Çakır', position: 'GK', number: 1, rating: 83.0, threatLevel: 10, isKeyPlayer: false, attributes: PlayerAttributes(pace: 45, shooting: 16, passing: 60, dribbling: 38, defending: 20, physical: 78)),
      SimulationPlayer(id: 'ts2', name: 'Enis Bardhi', position: 'CAM', number: 10, rating: 79.0, threatLevel: 70, isKeyPlayer: true, attributes: PlayerAttributes(pace: 72, shooting: 78, passing: 82, dribbling: 80, defending: 35, physical: 62)),
      SimulationPlayer(id: 'ts3', name: 'Simon Banza', position: 'ST', number: 17, rating: 80.0, threatLevel: 85, isKeyPlayer: true, attributes: PlayerAttributes(pace: 82, shooting: 82, passing: 65, dribbling: 78, defending: 40, physical: 86)),
      SimulationPlayer(id: 'ts4', name: 'Okay Yokuşlu', position: 'CDM', number: 6, rating: 79.0, threatLevel: 45, isKeyPlayer: false, attributes: PlayerAttributes(pace: 65, shooting: 65, passing: 78, dribbling: 72, defending: 82, physical: 85)),
      SimulationPlayer(id: 'ts5', name: 'Stefano Denswil', position: 'CB', number: 4, rating: 77.0, threatLevel: 20, isKeyPlayer: false, attributes: PlayerAttributes(pace: 70, shooting: 35, passing: 62, dribbling: 55, defending: 78, physical: 80)),
      SimulationPlayer(id: 'ts6', name: 'Stefan Savic', position: 'CB', number: 15, rating: 80.0, threatLevel: 25, isKeyPlayer: false, attributes: PlayerAttributes(pace: 68, shooting: 40, passing: 70, dribbling: 58, defending: 84, physical: 82)),
      SimulationPlayer(id: 'ts7', name: 'Pedro Malheiro', position: 'RB', number: 7, rating: 76.0, threatLevel: 50, isKeyPlayer: false, attributes: PlayerAttributes(pace: 84, shooting: 60, passing: 72, dribbling: 76, defending: 74, physical: 72)),
      SimulationPlayer(id: 'ts8', name: 'Eren Elmalı', position: 'LB', number: 18, rating: 77.0, threatLevel: 45, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 55, passing: 70, dribbling: 74, defending: 76, physical: 78)),
      SimulationPlayer(id: 'ts9', name: 'Batista Mendy', position: 'CDM', number: 5, rating: 79.0, threatLevel: 40, isKeyPlayer: false, attributes: PlayerAttributes(pace: 78, shooting: 65, passing: 72, dribbling: 78, defending: 80, physical: 88)),
      SimulationPlayer(id: 'ts10', name: 'Edin Višća', position: 'RW', number: 7, rating: 81.0, threatLevel: 80, isKeyPlayer: true, attributes: PlayerAttributes(pace: 84, shooting: 80, passing: 84, dribbling: 82, defending: 45, physical: 65)),
      SimulationPlayer(id: 'ts11', name: 'Anthony Nwakaeme', position: 'LW', number: 9, rating: 79.0, threatLevel: 80, isKeyPlayer: false, attributes: PlayerAttributes(pace: 75, shooting: 80, passing: 82, dribbling: 88, defending: 35, physical: 84)),
      // Bench
      SimulationPlayer(id: 'ts12', name: 'Muhammet Taha Tepe', position: 'GK', number: 54, rating: 72.0, threatLevel: 5, isKeyPlayer: false, attributes: PlayerAttributes(pace: 45, shooting: 15, passing: 58, dribbling: 35, defending: 20, physical: 74)),
      SimulationPlayer(id: 'ts13', name: 'Draguş', position: 'ST', number: 70, rating: 77.0, threatLevel: 75, isKeyPlayer: false, attributes: PlayerAttributes(pace: 88, shooting: 78, passing: 68, dribbling: 82, defending: 35, physical: 75)),
      SimulationPlayer(id: 'ts14', name: 'John Lundstram', position: 'CM', number: 8, rating: 77.0, threatLevel: 50, isKeyPlayer: false, attributes: PlayerAttributes(pace: 70, shooting: 75, passing: 78, dribbling: 72, defending: 76, physical: 84)),
      SimulationPlayer(id: 'ts15', name: 'Cihan Çanak', position: 'LW', number: 61, rating: 74.0, threatLevel: 65, isKeyPlayer: false, attributes: PlayerAttributes(pace: 82, shooting: 70, passing: 74, dribbling: 80, defending: 45, physical: 68)),
      SimulationPlayer(id: 'ts16', name: 'Boric', position: 'CB', number: 24, rating: 75.0, threatLevel: 25, isKeyPlayer: false, attributes: PlayerAttributes(pace: 72, shooting: 35, passing: 60, dribbling: 52, defending: 78, physical: 82)),
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
