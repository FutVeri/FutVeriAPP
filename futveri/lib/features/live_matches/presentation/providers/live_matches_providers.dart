import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/live_matches_remote_datasource.dart';
import '../../data/repositories/live_matches_repository_impl.dart';
import '../../domain/repositories/live_matches_repository.dart';
import '../../domain/usecases/get_live_matches_usecase.dart';
import '../../domain/usecases/get_match_detail_usecase.dart';

/// Data source provider
final liveMatchesRemoteDataSourceProvider = Provider<LiveMatchesRemoteDataSource>((ref) {
  return LiveMatchesRemoteDataSource();
});

/// Repository provider
final liveMatchesRepositoryProvider = Provider<LiveMatchesRepository>((ref) {
  return LiveMatchesRepositoryImpl(
    remoteDataSource: ref.watch(liveMatchesRemoteDataSourceProvider),
  );
});

/// Use case providers
final getLiveMatchesUseCaseProvider = Provider<GetLiveMatchesUseCase>((ref) {
  return GetLiveMatchesUseCase(ref.watch(liveMatchesRepositoryProvider));
});

final getMatchDetailUseCaseProvider = Provider<GetMatchDetailUseCase>((ref) {
  return GetMatchDetailUseCase(ref.watch(liveMatchesRepositoryProvider));
});
