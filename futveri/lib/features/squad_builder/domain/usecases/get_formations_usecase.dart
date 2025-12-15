import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/formation_entity.dart';
import '../repositories/squad_repository.dart';

/// Use case for getting formations
class GetFormationsUseCase {
  final SquadRepository repository;

  GetFormationsUseCase(this.repository);

  Future<Either<Failure, List<FormationEntity>>> call() async {
    return await repository.getFormations();
  }
}
