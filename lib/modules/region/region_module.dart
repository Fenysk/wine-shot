import 'package:get_it/get_it.dart';

import 'data/sources/region_remote_source.dart';
import 'data/repositories/region_repository_impl.dart';
import 'domain/repositories/region_repository.dart';
import 'domain/usecases/get_regions_usecase.dart';
import 'features/region_list/bloc/region_bloc.dart';

final GetIt di = GetIt.instance;

Future<void> registerRegionModule() async {
  // Register data sources
  di.registerLazySingleton<RegionRemoteSource>(() => RegionRemoteSourceImpl());

  // Register repository
  di.registerLazySingleton<RegionRepository>(
    () => RegionRepositoryImpl(remoteSource: di()),
  );

  // Register usecase
  di.registerLazySingleton<GetRegionsUsecase>(
    () => GetRegionsUsecase(repository: di()),
  );

  // Register bloc
  di.registerFactory<RegionBloc>(
    () => RegionBloc(getRegionsUsecase: di()),
  );

  // Register routes if needed (not required for dialog usage)
}
