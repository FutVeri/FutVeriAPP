import 'package:equatable/equatable.dart';

/// Match event types
enum MatchEventType {
  goal,
  yellowCard,
  redCard,
  substitution,
  penalty,
  ownGoal,
  varCheck,
}


/// Match event entity (timeline events)
class MatchEventEntity extends Equatable {
  final String id;
  final MatchEventType type;
  final int minute;
  final String? playerName;
  final String? teamId;
  final String? description;
  final Map<String, dynamic>? metadata;

  const MatchEventEntity({
    required this.id,
    required this.type,
    required this.minute,
    this.playerName,
    this.teamId,
    this.description,
    this.metadata,
  });

  @override
  List<Object?> get props => [id, type, minute, playerName, teamId, description];
}
