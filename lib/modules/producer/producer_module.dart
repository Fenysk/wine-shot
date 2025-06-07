import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../_core/constants.dart';
import 'data/repositories/producer_repository_impl.dart';
import 'data/sources/producer_remote_source.dart';
import 'domain/repositories/producer_repository.dart';
import 'domain/usecases/add_producer_usecase.dart';
import 'domain/usecases/delete_producer_usecase.dart';
import 'domain/usecases/get_producers_usecase.dart';
import 'bloc/producer_bloc.dart';
import 'features/new_producer/bloc/new_producer_bloc.dart';
import 'producer_routes.dart';

// Initialize GetIt instance
final GetIt di = GetIt.instance;

Future<void> registerProducerModule() async {
  // Register routes
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(producerRoutes());

  // Register source
  di.registerLazySingleton<ProducerRemoteSource>(() => ProducerRemoteSourceImpl());

  // Register repository
  di.registerLazySingleton<ProducerRepository>(() => ProducerRepositoryImpl(remoteSource: di()));

  // Register use cases
  di.registerLazySingleton<GetProducersUsecase>(() => GetProducersUsecase(repository: di()));
  di.registerLazySingleton<AddProducerUsecase>(() => AddProducerUsecase(repository: di()));
  di.registerLazySingleton<DeleteProducerUsecase>(() => DeleteProducerUsecase(repository: di()));

  // Register BLoCs
  di.registerFactory<ProducerBloc>(() => ProducerBloc(
        getProducersUsecase: di(),
        deleteProducerUsecase: di(),
      ));
  di.registerFactory<NewProducerBloc>(() => NewProducerBloc(addProducerUsecase: di()));
}
