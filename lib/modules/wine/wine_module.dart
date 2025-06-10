import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../_core/constants.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'data/repositories/wine_repository_impl.dart';
import 'data/sources/wine_remote_source.dart';
import 'domain/repositories/wine_repository.dart';
import 'domain/usecases/create_wine_usecase.dart';
import 'domain/usecases/delete_wine_usecase.dart';
import 'domain/usecases/get_wine_types_usecase.dart';
import 'domain/usecases/get_wines_usecase.dart';
import 'features/new_wine/bloc/new_wine_bloc.dart';
import 'features/wine_list/bloc/wine-types-list/wine_types_list_bloc.dart';
import 'wine_routes.dart';
import 'features/wine_list/bloc/wine-list/wine_list_bloc.dart';

final GetIt di = GetIt.instance;

Future<void> registerWineModule() async {
  // Data sources
  di.registerLazySingleton<WineRemoteSource>(() => WineRemoteSourceImpl());

  // Repositories
  di.registerLazySingleton<WineRepository>(() => WineRepositoryImpl(remoteSource: di()));

  // Use cases
  di.registerLazySingleton(() => GetWinesUseCase(repository: di()));
  di.registerLazySingleton(() => GetWineTypesUseCase(repository: di()));
  di.registerLazySingleton(() => CreateWineUseCase(repository: di()));
  di.registerLazySingleton(() => DeleteWineUseCase(repository: di()));

  // Bloc
  di.registerFactory<WineListBloc>(() => WineListBloc(
        getWinesUseCase: di(),
        deleteWineUseCase: di(),
      ));
  di.registerFactory<WineTypesListBloc>(() => WineTypesListBloc(getWineTypesUseCase: di()));
  di.registerFactory<NewWineBloc>(() => NewWineBloc(createWineUsecase: di()));

  // Register routes
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(wineRoutes);
}

void registerWineModuleWithContext(BuildContext context) {
  // Add all wine module navigation tabs
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getWineNavTabs(context));
}
