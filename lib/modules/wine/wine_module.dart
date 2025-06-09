import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../_core/constants.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'data/repositories/wine_repository_impl.dart';
import 'data/sources/wine_remote_source.dart';
import 'domain/repositories/wine_repository.dart';
import 'domain/usecases/get_wines_usecase.dart';
import 'wine_routes.dart';
import 'features/wine_list/bloc/wine_list_bloc.dart';

final GetIt di = GetIt.instance;

Future<void> registerWineModule() async {
  // Data sources
  di.registerLazySingleton<WineRemoteSource>(() => WineRemoteSourceImpl());

  // Repositories
  di.registerLazySingleton<WineRepository>(() => WineRepositoryImpl(remoteSource: di()));

  // Use cases
  di.registerLazySingleton(() => GetWinesUseCase(repository: di()));

  // Bloc
  di.registerFactory<WineListBloc>(() => WineListBloc(getWinesUseCase: di()));

  // Register routes
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(wineRoutes);
}

void registerWineModuleWithContext(BuildContext context) {
  // Add all wine module navigation tabs
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getWineNavTabs(context));
}
