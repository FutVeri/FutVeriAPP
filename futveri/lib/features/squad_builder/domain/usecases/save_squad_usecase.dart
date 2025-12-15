import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/squad_entity.dart';
import '../repositories/squad_repository.dart';

/// Use case for saving squad
class SaveSquadUseCase {
  final SquadRepository repository;

  SaveSquadUseCase(this.repository);

  Future<Either<Failure, void>> call(SquadEntity squad) async {
    return await repository.saveSquad(squad);
  }
}
