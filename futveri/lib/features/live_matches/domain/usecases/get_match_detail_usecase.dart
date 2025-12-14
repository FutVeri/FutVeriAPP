import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/match_entity.dart';
import '../entities/match_event_entity.dart';
import '../entities/match_stats_entity.dart';
import '../repositories/live_matches_repository.dart';

/// Match detail data (aggregated)
class MatchDetail {
  final MatchEntity match;
  final List<MatchEventEntity> events;
  final MatchStatsEntity stats;

  const MatchDetail({
    required this.match,
    required this.events,
    required this.stats,
  });
}

/// Use case: Get match detail with events and stats
class GetMatchDetailUseCase {
  final LiveMatchesRepository repository;

  GetMatchDetailUseCase(this.repository);

  Future<Result<MatchDetail>> call(String matchId) async {
    try {
      final matchResult = await repository.getMatchById(matchId);
      final eventsResult = await repository.getMatchEvents(matchId);
      final statsResult = await repository.getMatchStats(matchId);

      // Check if any failed
      if (matchResult.isLeft()) return matchResult.fold((l) => Left(l), (r) => throw Exception());
      if (eventsResult.isLeft()) return eventsResult.fold((l) => Left(l), (r) => throw Exception());
      if (statsResult.isLeft()) return statsResult.fold((l) => Left(l), (r) => throw Exception());

      // Extract values
      final match = matchResult.getOrElse(() => throw Exception());
      final events = eventsResult.getOrElse(() => throw Exception());
      final stats = statsResult.getOrElse(() => throw Exception());

      return Right(MatchDetail(
        match: match,
        events: events,
        stats: stats,
      ));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Failed to get match detail: $e'));
    }
  }
}
