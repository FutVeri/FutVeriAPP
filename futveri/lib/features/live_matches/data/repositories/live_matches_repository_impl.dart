import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/match_entity.dart';
import '../../domain/entities/match_event_entity.dart';
import '../../domain/entities/match_stats_entity.dart';
import '../../domain/repositories/live_matches_repository.dart';
import '../datasources/live_matches_remote_datasource.dart';

/// Repository implementation with offline-first approach
class LiveMatchesRepositoryImpl implements LiveMatchesRepository {
  final LiveMatchesRemoteDataSource remoteDataSource;
  // TODO: Add local data source for caching

  LiveMatchesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<List<MatchEntity>>> getLiveMatches() async {
    try {
      AppLogger.info('📡 Fetching live matches...');
      
      // TODO: Try to get from cache first (offline-first)
      // For now, just fetch from remote
      final matchDtos = await remoteDataSource.getLiveMatches();
      final matches = matchDtos.map((dto) => dto.toEntity()).toList();
      
      AppLogger.info('✅ Fetched ${matches.length} live matches');
      
      // TODO: Cache the results
      
      return Right(matches);
    } on ServerException catch (e) {
      AppLogger.error('❌ Server error fetching live matches', e);
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('❌ Network error fetching live matches', e);
      return Left(NetworkFailure(message: e.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Unexpected error fetching live matches', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<MatchEntity>> getMatchById(String matchId) async {
    try {
      AppLogger.info('📡 Fetching match $matchId...');
      
      final matchDto = await remoteDataSource.getMatchById(matchId);
      final match = matchDto.toEntity();
      
      AppLogger.info('✅ Fetched match: ${match.homeTeam.name} vs ${match.awayTeam.name}');
      
      return Right(match);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e, stackTrace) {
      AppLogger.error('❌ Error fetching match $matchId', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<MatchEventEntity>>> getMatchEvents(String matchId) async {
    try {
      AppLogger.info('📡 Fetching events for match $matchId...');
      
      final eventDtos = await remoteDataSource.getMatchEvents(matchId);
      final events = eventDtos.map((dto) => dto.toEntity()).toList();
      
      AppLogger.info('✅ Fetched ${events.length} events');
      
      return Right(events);
    } catch (e, stackTrace) {
      AppLogger.error('❌ Error fetching match events', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<MatchStatsEntity>> getMatchStats(String matchId) async {
    try {
      AppLogger.info('📡 Fetching stats for match $matchId...');
      
      final statsDto = await remoteDataSource.getMatchStats(matchId);
      final stats = statsDto.toEntity();
      
      AppLogger.info('✅ Fetched match stats');
      
      return Right(stats);
    } catch (e, stackTrace) {
      AppLogger.error('❌ Error fetching match stats', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<MatchEntity>>> refreshLiveMatches() async {
    // For now, same as getLiveMatches (force remote fetch)
    // TODO: Clear cache and fetch fresh data
    return getLiveMatches();
  }
}
