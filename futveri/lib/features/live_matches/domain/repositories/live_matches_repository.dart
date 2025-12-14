import '../../../../core/error/failures.dart';
import '../entities/match_entity.dart';
import '../entities/match_event_entity.dart';
import '../entities/match_stats_entity.dart';

/// Repository interface for live matches
abstract class LiveMatchesRepository {
  /// Get all live matches
  Future<Result<List<MatchEntity>>> getLiveMatches();

  /// Get match by ID
  Future<Result<MatchEntity>> getMatchById(String matchId);

  /// Get match events timeline
  Future<Result<List<MatchEventEntity>>> getMatchEvents(String matchId);

  /// Get match statistics
  Future<Result<MatchStatsEntity>> getMatchStats(String matchId);

  /// Refresh live matches (force fetch from remote)
  Future<Result<List<MatchEntity>>> refreshLiveMatches();
}
