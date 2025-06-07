import 'package:get_it/get_it.dart';

import 'data/repositories/country_repository_impl.dart';
import 'data/sources/country_remote_source.dart';
import 'domain/repositories/country_repository.dart';
import 'domain/usecases/get_countries.dart';
import 'features/country_list/bloc/country_list_bloc.dart';

final GetIt di = GetIt.instance;

Future<void> registerCountryModule() async {
  // BLoC
  di.registerFactory(() => CountryListBloc(getCountries: di()));

  // Use cases
  di.registerLazySingleton(() => GetCountries(di()));

  // Repository
  di.registerLazySingleton<CountryRepository>(() => CountryRepositoryImpl(remoteSource: di()));

  // Data sources
  di.registerLazySingleton<CountryRemoteSource>(() => CountryRemoteSourceImpl());
}
