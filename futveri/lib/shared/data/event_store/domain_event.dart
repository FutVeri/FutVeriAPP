import 'package:isar/isar.dart';

part 'domain_event.g.dart';

/// Base class for all domain events (Event Sourcing)
@collection
class DomainEvent {
  Id id = Isar.autoIncrement;

  /// Event type (e.g., 'MatchSynced', 'GoalEventReceived', 'UserFavoritedTeam')
  @Index()
  late String type;

  /// When the event occurred
  @Index()
  late DateTime occurredAt;

  /// Actor who triggered the event (user ID, system, etc.)
  String? actor;

  /// Event payload as JSON string
  late String payloadJson;

  /// Event schema version (for migration)
  late int version;

  /// Correlation ID for tracking related events
  @Index()
  String? correlationId;

  /// Whether this event has been synced to remote
  @Index()
  bool synced;

  DomainEvent({
    required this.type,
    required this.occurredAt,
    required this.payloadJson,
    this.actor,
    this.version = 1,
    this.correlationId,
    this.synced = false,
  });

  DomainEvent.empty()
      : type = '',
        occurredAt = DateTime.now(),
        payloadJson = '{}',
        version = 1,
        synced = false;
}
