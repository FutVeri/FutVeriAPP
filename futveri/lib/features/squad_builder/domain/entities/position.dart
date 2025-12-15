/// Football positions
enum Position {
  // Goalkeeper
  gk('GK', 'Goalkeeper', PositionCategory.goalkeeper),
  
  // Defenders
  cb('CB', 'Center Back', PositionCategory.defender),
  lb('LB', 'Left Back', PositionCategory.defender),
  rb('RB', 'Right Back', PositionCategory.defender),
  lwb('LWB', 'Left Wing Back', PositionCategory.defender),
  rwb('RWB', 'Right Wing Back', PositionCategory.defender),
  
  // Midfielders
  cdm('CDM', 'Defensive Midfielder', PositionCategory.midfielder),
  cm('CM', 'Central Midfielder', PositionCategory.midfielder),
  cam('CAM', 'Attacking Midfielder', PositionCategory.midfielder),
  lm('LM', 'Left Midfielder', PositionCategory.midfielder),
  rm('RM', 'Right Midfielder', PositionCategory.midfielder),
  
  // Forwards
  lw('LW', 'Left Winger', PositionCategory.forward),
  rw('RW', 'Right Winger', PositionCategory.forward),
  cf('CF', 'Center Forward', PositionCategory.forward),
  st('ST', 'Striker', PositionCategory.forward);

  final String code;
  final String fullName;
  final PositionCategory category;

  const Position(this.code, this.fullName, this.category);

  /// Check if this position is compatible with another position
  bool isCompatibleWith(Position other) {
    if (this == other) return true;
    
    // Same category positions are somewhat compatible
    if (category == other.category) {
      return true;
    }
    
    // Special compatibility rules
    switch (this) {
      case Position.lwb:
        return other == Position.lb || other == Position.lm;
      case Position.rwb:
        return other == Position.rb || other == Position.rm;
      case Position.cdm:
        return other == Position.cm || other == Position.cb;
      case Position.cam:
        return other == Position.cm || other == Position.cf;
      case Position.cf:
        return other == Position.st || other == Position.cam;
      default:
        return false;
    }
  }
}

/// Position categories
enum PositionCategory {
  goalkeeper,
  defender,
  midfielder,
  forward;

  String get displayName {
    switch (this) {
      case PositionCategory.goalkeeper:
        return 'Goalkeeper';
      case PositionCategory.defender:
        return 'Defender';
      case PositionCategory.midfielder:
        return 'Midfielder';
      case PositionCategory.forward:
        return 'Forward';
    }
  }
}

/// Preferred foot
enum PreferredFoot {
  left('Left'),
  right('Right'),
  both('Both');

  final String displayName;
  const PreferredFoot(this.displayName);
}
