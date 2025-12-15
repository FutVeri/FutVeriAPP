import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/player_entity.dart';
import '../entities/formation_entity.dart';
import '../entities/squad_entity.dart';
import '../entities/position.dart';

/// Squad repository interface
abstract class SquadRepository {
  /// Get all available players
  Future<Either<Failure, List<PlayerEntity>>> getAvailablePlayers();

  /// Search players by name or filters
  Future<Either<Failure, List<PlayerEntity>>> searchPlayers({
    String? query,
    Position? position,
    int? minRating,
    int? maxRating,
  });

  /// Get all formations
  Future<Either<Failure, List<FormationEntity>>> getFormations();

  /// Save squad
  Future<Either<Failure, void>> saveSquad(SquadEntity squad);

  /// Load user's squad
  Future<Either<Failure, SquadEntity?>> loadSquad(String userId);

  /// Delete squad
  Future<Either<Failure, void>> deleteSquad(String squadId);
}
