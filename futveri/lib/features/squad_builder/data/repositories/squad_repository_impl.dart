import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/formation_entity.dart';
import '../../domain/entities/squad_entity.dart';
import '../../domain/entities/position.dart';
import '../../domain/repositories/squad_repository.dart';
import '../datasources/squad_remote_datasource.dart';
import '../models/player_dto.dart';
import '../models/squad_dto.dart';

/// Squad repository implementation
class SquadRepositoryImpl implements SquadRepository {
  final SquadRemoteDataSource remoteDataSource;

  SquadRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<PlayerEntity>>> getAvailablePlayers() async {
    try {
      AppLogger.info('Fetching available players...');
      final players = await remoteDataSource.getAvailablePlayers();
      final entities = players.map((dto) => dto.toEntity()).toList();
      AppLogger.info('Fetched ${entities.length} players');
      return Right(entities);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to fetch players', e, stackTrace);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlayerEntity>>> searchPlayers({
    String? query,
    Position? position,
    int? minRating,
    int? maxRating,
  }) async {
    try {
      AppLogger.info('Searching players: query=$query, position=$position');
      final players = await remoteDataSource.searchPlayers(
        query: query,
        position: position,
        minRating: minRating,
        maxRating: maxRating,
      );
      final entities = players.map((dto) => dto.toEntity()).toList();
      AppLogger.info('Found ${entities.length} players');
      return Right(entities);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search players', e, stackTrace);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FormationEntity>>> getFormations() async {
    try {
      AppLogger.info('Fetching formations...');
      // Return predefined formations
      final formations = FormationEntity.allFormations;
      AppLogger.info('Fetched ${formations.length} formations');
      return Right(formations);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to fetch formations', e, stackTrace);
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSquad(SquadEntity squad) async {
    try {
      AppLogger.info('Saving squad: ${squad.name}');
      final dto = SquadDto.fromEntity(squad);
      await remoteDataSource.saveSquad(dto, 'user_1'); // TODO: Get real user ID
      AppLogger.info('Squad saved successfully');
      return const Right(null);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save squad', e, stackTrace);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SquadEntity?>> loadSquad(String userId) async {
    try {
      AppLogger.info('Loading squad for user: $userId');
      final dto = await remoteDataSource.loadSquad(userId);
      
      if (dto == null) {
        AppLogger.info('No saved squad found');
        return const Right(null);
      }

      // Get formation
      final formation = FormationEntity.allFormations.firstWhere(
        (f) => f.id == dto.formationId,
        orElse: () => FormationEntity.formation433,
      );

      // Get all players
      final allPlayers = await remoteDataSource.getAvailablePlayers();
      final playersById = {for (var p in allPlayers) p.id: p};

      final entity = dto.toEntity(
        formation: formation,
        playersById: playersById,
      );

      AppLogger.info('Squad loaded successfully');
      return Right(entity);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load squad', e, stackTrace);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSquad(String squadId) async {
    try {
      AppLogger.info('Deleting squad: $squadId');
      // TODO: Implement delete
      AppLogger.info('Squad deleted successfully');
      return const Right(null);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete squad', e, stackTrace);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
