import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/squad_remote_datasource.dart';
import '../../data/repositories/squad_repository_impl.dart';
import '../../domain/repositories/squad_repository.dart';
import '../../domain/usecases/get_available_players_usecase.dart';
import '../../domain/usecases/get_formations_usecase.dart';
import '../../domain/usecases/save_squad_usecase.dart';
import '../../domain/usecases/load_squad_usecase.dart';

/// Data source provider
final squadRemoteDataSourceProvider = Provider<SquadRemoteDataSource>((ref) {
  return SquadRemoteDataSource();
});

/// Repository provider
final squadRepositoryProvider = Provider<SquadRepository>((ref) {
  return SquadRepositoryImpl(
    remoteDataSource: ref.watch(squadRemoteDataSourceProvider),
  );
});

/// Use case providers
final getAvailablePlayersUseCaseProvider = Provider<GetAvailablePlayersUseCase>((ref) {
  return GetAvailablePlayersUseCase(ref.watch(squadRepositoryProvider));
});

final getFormationsUseCaseProvider = Provider<GetFormationsUseCase>((ref) {
  return GetFormationsUseCase(ref.watch(squadRepositoryProvider));
});

final saveSquadUseCaseProvider = Provider<SaveSquadUseCase>((ref) {
  return SaveSquadUseCase(ref.watch(squadRepositoryProvider));
});

final loadSquadUseCaseProvider = Provider<LoadSquadUseCase>((ref) {
  return LoadSquadUseCase(ref.watch(squadRepositoryProvider));
});
