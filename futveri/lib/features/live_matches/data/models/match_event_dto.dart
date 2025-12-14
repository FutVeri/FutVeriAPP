import '../../domain/entities/match_event_entity.dart';

/// Match event DTO
class MatchEventDto {
  final String id;
  final String type;
  final int minute;
  final String? playerName;
  final String? teamId;
  final String? description;
  final Map<String, dynamic>? metadata;

  MatchEventDto({
    required this.id,
    required this.type,
    required this.minute,
    this.playerName,
    this.teamId,
    this.description,
    this.metadata,
  });

  factory MatchEventDto.fromJson(Map<String, dynamic> json) {
    return MatchEventDto(
      id: json['id'] as String,
      type: json['type'] as String,
      minute: json['minute'] as int,
      playerName: json['playerName'] as String?,
      teamId: json['teamId'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'minute': minute,
      'playerName': playerName,
      'teamId': teamId,
      'description': description,
      'metadata': metadata,
    };
  }

  MatchEventEntity toEntity() {
    return MatchEventEntity(
      id: id,
      type: _parseEventType(type),
      minute: minute,
      playerName: playerName,
      teamId: teamId,
      description: description,
      metadata: metadata,
    );
  }

  MatchEventType _parseEventType(String type) {
    switch (type.toLowerCase()) {
      case 'goal':
        return MatchEventType.goal;
      case 'yellow_card':
      case 'yellowcard':
        return MatchEventType.yellowCard;
      case 'red_card':
      case 'redcard':
        return MatchEventType.redCard;
      case 'substitution':
        return MatchEventType.substitution;
      case 'penalty':
        return MatchEventType.penalty;
      case 'own_goal':
      case 'owngoal':
        return MatchEventType.ownGoal;
      case 'var':
        return MatchEventType.varCheck;

      default:
        return MatchEventType.goal;
    }
  }
}
