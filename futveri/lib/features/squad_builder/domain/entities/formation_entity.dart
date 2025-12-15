import 'package:equatable/equatable.dart';
import 'position.dart';

/// Position on the pitch (x, y coordinates)
class PitchPosition extends Equatable {
  final double x; // 0.0 to 1.0 (left to right)
  final double y; // 0.0 to 1.0 (top to bottom)
  final Position position;

  const PitchPosition({
    required this.x,
    required this.y,
    required this.position,
  });

  @override
  List<Object?> get props => [x, y, position];
}

/// Formation entity
class FormationEntity extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final List<PitchPosition> positions;

  const FormationEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.positions,
  });

  /// Get all predefined formations
  static List<FormationEntity> get allFormations => [
        formation433,
        formation442,
        formation4231,
        formation352,
        formation41212,
        formation4321,
      ];

  /// 4-3-3 Formation
  static const FormationEntity formation433 = FormationEntity(
    id: '433',
    name: '4-3-3',
    displayName: '4-3-3 Attack',
    positions: [
      // GK
      PitchPosition(x: 0.5, y: 0.95, position: Position.gk),
      
      // Defenders
      PitchPosition(x: 0.15, y: 0.75, position: Position.lb),
      PitchPosition(x: 0.35, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.65, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.85, y: 0.75, position: Position.rb),
      
      // Midfielders
      PitchPosition(x: 0.5, y: 0.55, position: Position.cm),
      PitchPosition(x: 0.3, y: 0.5, position: Position.cm),
      PitchPosition(x: 0.7, y: 0.5, position: Position.cm),
      
      // Forwards
      PitchPosition(x: 0.15, y: 0.2, position: Position.lw),
      PitchPosition(x: 0.5, y: 0.15, position: Position.st),
      PitchPosition(x: 0.85, y: 0.2, position: Position.rw),
    ],
  );

  /// 4-4-2 Formation
  static const FormationEntity formation442 = FormationEntity(
    id: '442',
    name: '4-4-2',
    displayName: '4-4-2 Classic',
    positions: [
      // GK
      PitchPosition(x: 0.5, y: 0.95, position: Position.gk),
      
      // Defenders
      PitchPosition(x: 0.15, y: 0.75, position: Position.lb),
      PitchPosition(x: 0.35, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.65, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.85, y: 0.75, position: Position.rb),
      
      // Midfielders
      PitchPosition(x: 0.15, y: 0.5, position: Position.lm),
      PitchPosition(x: 0.38, y: 0.5, position: Position.cm),
      PitchPosition(x: 0.62, y: 0.5, position: Position.cm),
      PitchPosition(x: 0.85, y: 0.5, position: Position.rm),
      
      // Forwards
      PitchPosition(x: 0.35, y: 0.2, position: Position.st),
      PitchPosition(x: 0.65, y: 0.2, position: Position.st),
    ],
  );

  /// 4-2-3-1 Formation
  static const FormationEntity formation4231 = FormationEntity(
    id: '4231',
    name: '4-2-3-1',
    displayName: '4-2-3-1 Wide',
    positions: [
      // GK
      PitchPosition(x: 0.5, y: 0.95, position: Position.gk),
      
      // Defenders
      PitchPosition(x: 0.15, y: 0.75, position: Position.lb),
      PitchPosition(x: 0.35, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.65, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.85, y: 0.75, position: Position.rb),
      
      // Defensive Midfielders
      PitchPosition(x: 0.38, y: 0.6, position: Position.cdm),
      PitchPosition(x: 0.62, y: 0.6, position: Position.cdm),
      
      // Attacking Midfielders
      PitchPosition(x: 0.15, y: 0.35, position: Position.lm),
      PitchPosition(x: 0.5, y: 0.4, position: Position.cam),
      PitchPosition(x: 0.85, y: 0.35, position: Position.rm),
      
      // Forward
      PitchPosition(x: 0.5, y: 0.15, position: Position.st),
    ],
  );

  /// 3-5-2 Formation
  static const FormationEntity formation352 = FormationEntity(
    id: '352',
    name: '3-5-2',
    displayName: '3-5-2 Wing',
    positions: [
      // GK
      PitchPosition(x: 0.5, y: 0.95, position: Position.gk),
      
      // Defenders
      PitchPosition(x: 0.25, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.5, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.75, y: 0.75, position: Position.cb),
      
      // Midfielders
      PitchPosition(x: 0.1, y: 0.5, position: Position.lwb),
      PitchPosition(x: 0.35, y: 0.55, position: Position.cm),
      PitchPosition(x: 0.5, y: 0.5, position: Position.cdm),
      PitchPosition(x: 0.65, y: 0.55, position: Position.cm),
      PitchPosition(x: 0.9, y: 0.5, position: Position.rwb),
      
      // Forwards
      PitchPosition(x: 0.4, y: 0.2, position: Position.st),
      PitchPosition(x: 0.6, y: 0.2, position: Position.st),
    ],
  );

  /// 4-1-2-1-2 Formation
  static const FormationEntity formation41212 = FormationEntity(
    id: '41212',
    name: '4-1-2-1-2',
    displayName: '4-1-2-1-2 Narrow',
    positions: [
      // GK
      PitchPosition(x: 0.5, y: 0.95, position: Position.gk),
      
      // Defenders
      PitchPosition(x: 0.15, y: 0.75, position: Position.lb),
      PitchPosition(x: 0.35, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.65, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.85, y: 0.75, position: Position.rb),
      
      // Defensive Midfielder
      PitchPosition(x: 0.5, y: 0.6, position: Position.cdm),
      
      // Central Midfielders
      PitchPosition(x: 0.35, y: 0.48, position: Position.cm),
      PitchPosition(x: 0.65, y: 0.48, position: Position.cm),
      
      // Attacking Midfielder
      PitchPosition(x: 0.5, y: 0.32, position: Position.cam),
      
      // Forwards
      PitchPosition(x: 0.4, y: 0.15, position: Position.st),
      PitchPosition(x: 0.6, y: 0.15, position: Position.st),
    ],
  );

  /// 4-3-2-1 Formation
  static const FormationEntity formation4321 = FormationEntity(
    id: '4321',
    name: '4-3-2-1',
    displayName: '4-3-2-1 Christmas Tree',
    positions: [
      // GK
      PitchPosition(x: 0.5, y: 0.95, position: Position.gk),
      
      // Defenders
      PitchPosition(x: 0.15, y: 0.75, position: Position.lb),
      PitchPosition(x: 0.35, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.65, y: 0.75, position: Position.cb),
      PitchPosition(x: 0.85, y: 0.75, position: Position.rb),
      
      // Midfielders
      PitchPosition(x: 0.5, y: 0.6, position: Position.cdm),
      PitchPosition(x: 0.3, y: 0.52, position: Position.cm),
      PitchPosition(x: 0.7, y: 0.52, position: Position.cm),
      
      // Attacking Midfielders
      PitchPosition(x: 0.35, y: 0.32, position: Position.cam),
      PitchPosition(x: 0.65, y: 0.32, position: Position.cam),
      
      // Forward
      PitchPosition(x: 0.5, y: 0.15, position: Position.st),
    ],
  );

  @override
  List<Object?> get props => [id, name, displayName, positions];
}
