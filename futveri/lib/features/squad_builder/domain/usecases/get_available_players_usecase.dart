import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/player_entity.dart';
import '../repositories/squad_repository.dart';
import '../entities/position.dart';

/// Use case for getting available players
class GetAvailablePlayersUseCase {
  final SquadRepository repository;

  GetAvailablePlayersUseCase(this.repository);

  Future<Either<Failure, List<PlayerEntity>>> call({
    String? query,
    Position? position,
    int? minRating,
    int? maxRating,
  }) async {
    if (query != null || position != null || minRating != null || maxRating != null) {
      return await repository.searchPlayers(
        query: query,
        position: position,
        minRating: minRating,
        maxRating: maxRating,
      );
    }
    
    return await repository.getAvailablePlayers();
  }
}
