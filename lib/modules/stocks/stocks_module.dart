import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../_core/constants.dart';
import 'data/repositories/stock_repository_impl.dart';
import 'data/sources/stock_remote_source.dart';
import 'domain/repositories/stock_repository.dart';
import 'domain/usecases/get_stocks_usecase.dart';
import 'features/stock_list/bloc/stocks_list_bloc.dart';
import 'stocks_routes.dart';

final GetIt di = GetIt.instance;

Future<void> registerStocksModule() async {
  // Data sources
  di.registerLazySingleton<StockRemoteSource>(() => StockRemoteSourceImpl());

  // Repositories
  di.registerLazySingleton<StockRepository>(() => StockRepositoryImpl(remoteSource: di()));

  // Use cases
  di.registerLazySingleton(() => GetStocksUseCase(repository: di()));

  // Bloc
  di.registerFactory<StocksListBloc>(() => StocksListBloc(getStocksUseCase: di()));

  // Routes
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(stocksRoutes);
}
