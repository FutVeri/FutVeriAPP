import '../../../../core/error/failures.dart';
import '../entities/match_entity.dart';
import '../repositories/live_matches_repository.dart';

/// Use case: Get live matches
class GetLiveMatchesUseCase {
  final LiveMatchesRepository repository;

  GetLiveMatchesUseCase(this.repository);

  Future<Result<List<MatchEntity>>> call() async {
    return await repository.getLiveMatches();
  }
}
