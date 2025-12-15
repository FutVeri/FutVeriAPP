import 'package:equatable/equatable.dart';
import 'position.dart';

/// Player entity
class PlayerEntity extends Equatable {
  final String id;
  final String name;
  final String nationality;
  final Position primaryPosition;
  final List<Position> alternativePositions;
  final PreferredFoot preferredFoot;
  final String? photoUrl;
  
  // Attributes (0-99)
  final int pace;
  final int shooting;
  final int passing;
  final int dribbling;
  final int defending;
  final int physical;
  
  // Additional info
  final int age;
  final String? club;
  final int? jerseyNumber;

  const PlayerEntity({
    required this.id,
    required this.name,
    required this.nationality,
    required this.primaryPosition,
    this.alternativePositions = const [],
    required this.preferredFoot,
    this.photoUrl,
    required this.pace,
    required this.shooting,
    required this.passing,
    required this.dribbling,
    required this.defending,
    required this.physical,
    required this.age,
    this.club,
    this.jerseyNumber,
  });

  /// Calculate overall rating based on position
  int get overallRating {
    switch (primaryPosition.category) {
      case PositionCategory.goalkeeper:
        // For GK: defending and physical are most important
        return ((defending * 0.4) + 
                (physical * 0.3) + 
                (pace * 0.1) + 
                (passing * 0.1) + 
                (dribbling * 0.05) + 
                (shooting * 0.05)).round();
      
      case PositionCategory.defender:
        return ((defending * 0.35) + 
                (physical * 0.25) + 
                (pace * 0.2) + 
                (passing * 0.15) + 
                (dribbling * 0.05)).round();
      
      case PositionCategory.midfielder:
        return ((passing * 0.3) + 
                (dribbling * 0.25) + 
                (pace * 0.15) + 
                (physical * 0.15) + 
                (defending * 0.1) + 
                (shooting * 0.05)).round();
      
      case PositionCategory.forward:
        return ((shooting * 0.35) + 
                (pace * 0.25) + 
                (dribbling * 0.2) + 
                (passing * 0.1) + 
                (physical * 0.1)).round();
    }
  }

  /// Get position-specific rating
  int getRatingForPosition(Position position) {
    if (position == primaryPosition) {
      return overallRating;
    }
    
    if (alternativePositions.contains(position)) {
      return (overallRating * 0.95).round();
    }
    
    if (primaryPosition.isCompatibleWith(position)) {
      return (overallRating * 0.85).round();
    }
    
    // Incompatible position
    return (overallRating * 0.7).round();
  }

  /// Check if player can play in position
  bool canPlayIn(Position position) {
    return position == primaryPosition || 
           alternativePositions.contains(position) ||
           primaryPosition.isCompatibleWith(position);
  }

  /// Get rating color based on value
  static String getRatingColor(int rating) {
    if (rating >= 85) return '#00D9A3'; // Elite - Green
    if (rating >= 75) return '#FFA502'; // Good - Yellow
    if (rating >= 65) return '#FF6B6B'; // Average - Orange
    return '#8B949E'; // Below average - Gray
  }

  @override
  List<Object?> get props => [
        id,
        name,
        nationality,
        primaryPosition,
        alternativePositions,
        preferredFoot,
        photoUrl,
        pace,
        shooting,
        passing,
        dribbling,
        defending,
        physical,
        age,
        club,
        jerseyNumber,
      ];
}
