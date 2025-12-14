import '../../../core/error/failures.dart';
import 'domain_event.dart';

/// Repository interface for event storage
abstract class EventRepository {
  /// Store a new event
  Future<Result<void>> storeEvent(DomainEvent event);

  /// Get all events of a specific type
  Future<Result<List<DomainEvent>>> getEventsByType(String type);

  /// Get events by correlation ID
  Future<Result<List<DomainEvent>>> getEventsByCorrelationId(String correlationId);

  /// Get unsynced events (for remote sync)
  Future<Result<List<DomainEvent>>> getUnsyncedEvents();

  /// Mark events as synced
  Future<Result<void>> markEventsSynced(List<int> eventIds);

  /// Get events within a time range
  Future<Result<List<DomainEvent>>> getEventsByTimeRange(
    DateTime start,
    DateTime end,
  );

  /// Clear old events (for maintenance)
  Future<Result<void>> clearEventsOlderThan(DateTime date);
}
