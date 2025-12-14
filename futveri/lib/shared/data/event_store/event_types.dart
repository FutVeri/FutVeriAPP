/// Event type constants
class EventTypes {
  // Match events
  static const String matchSynced = 'MatchSynced';
  static const String goalEventReceived = 'GoalEventReceived';
  static const String cardEventReceived = 'CardEventReceived';
  static const String substitutionEventReceived = 'SubstitutionEventReceived';
  
  // User events
  static const String userFavoritedTeam = 'UserFavoritedTeam';
  static const String userUnfavoritedTeam = 'UserUnfavoritedTeam';
  static const String userFavoritedPlayer = 'UserFavoritedPlayer';
  
  // Simulation events
  static const String simMatchPlayed = 'SimMatchPlayed';
  static const String squadUpdated = 'SquadUpdated';
  static const String tacticChanged = 'TacticChanged';
  
  // AI events
  static const String aiInsightGenerated = 'AiInsightGenerated';
  static const String aiInsightCached = 'AiInsightCached';
  
  // System events
  static const String appLaunched = 'AppLaunched';
  static const String dataSynced = 'DataSynced';
}
