// Simulation Models for AI Analysis

class SimulationTeam {
  final String id;
  final String name;
  final String shortName;
  final String logoUrl;
  final String formation;
  final double overallRating;
  final List<String> recentForm; // W, L, D
  final List<SimulationPlayer> players;
  final TeamStrengths strengths;

  const SimulationTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.logoUrl,
    required this.formation,
    required this.overallRating,
    required this.recentForm,
    required this.players,
    required this.strengths,
  });
}

class SimulationPlayer {
  final String id;
  final String name;
  final String position;
  final int number;
  final double rating;
  final double threatLevel; // 0-100
  final bool isKeyPlayer;
  final PlayerAttributes attributes;

  const SimulationPlayer({
    required this.id,
    required this.name,
    required this.position,
    required this.number,
    required this.rating,
    required this.threatLevel,
    required this.isKeyPlayer,
    required this.attributes,
  });
}

class PlayerAttributes {
  final int pace;
  final int shooting;
  final int passing;
  final int dribbling;
  final int defending;
  final int physical;

  const PlayerAttributes({
    required this.pace,
    required this.shooting,
    required this.passing,
    required this.dribbling,
    required this.defending,
    required this.physical,
  });
}

class TeamStrengths {
  final int attack;
  final int midfield;
  final int defense;
  final int setPieces;
  final List<String> strongPoints;
  final List<String> weakPoints;

  const TeamStrengths({
    required this.attack,
    required this.midfield,
    required this.defense,
    required this.setPieces,
    required this.strongPoints,
    required this.weakPoints,
  });
}

class MatchAnalysis {
  final SimulationTeam homeTeam;
  final SimulationTeam awayTeam;
  final double homeWinProbability;
  final double drawProbability;
  final double awayWinProbability;
  final List<TacticalSuggestion> suggestions;
  final List<KeyMatchup> keyMatchups;

  const MatchAnalysis({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeWinProbability,
    required this.drawProbability,
    required this.awayWinProbability,
    required this.suggestions,
    required this.keyMatchups,
  });
}

class TacticalSuggestion {
  final String title;
  final String description;
  final String priority; // high, medium, low
  final String category; // attack, defense, midfield, setpiece

  const TacticalSuggestion({
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
  });
}

class KeyMatchup {
  final SimulationPlayer player1;
  final SimulationPlayer player2;
  final String description;
  final double advantageScore; // -100 to 100 (negative = player2 advantage)

  const KeyMatchup({
    required this.player1,
    required this.player2,
    required this.description,
    required this.advantageScore,
  });
}
