import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/squad_entity.dart';
import '../repositories/squad_repository.dart';

/// Use case for loading squad
class LoadSquadUseCase {
  final SquadRepository repository;

  LoadSquadUseCase(this.repository);

  Future<Either<Failure, SquadEntity?>> call(String userId) async {
    return await repository.loadSquad(userId);
  }
}
