import 'package:clean_starter/modules/auth/data/sources/auth_supabase_source.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../_core/constants.dart';
import '../../_core/di.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'auth_routes.dart';
import 'bloc/auth_bloc.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/models/user_model.dart';
import 'data/sources/profile_supabase_source.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_user_stream_usecase.dart';
import 'domain/usecases/is_authenticated_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/get_current_user_usecase.dart';
import 'domain/usecases/update_cached_user_usecase.dart';
import 'features/login/bloc/login_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'features/register/bloc/register_bloc.dart';

Future<void> registerAuthModule() async {
  //* register Hive Adapters
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    di<HiveInterface>().registerAdapter<UserModel>(UserModelAdapter());
  }

  //* Register Hive Box(es)
  if (!di.isRegistered<Box<UserModel>>()) {
    final userBox = await Hive.openBox<UserModel>('userBox');
    di.registerLazySingleton<Box<UserModel>>(() => userBox);
  }

  //* inject repositories
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dio: di(), hive: di(), networkInfo: di()));

  //* inject sources
  di.registerLazySingleton<AuthSupabaseSource>(() => AuthSupabaseSourceImpl());
  di.registerLazySingleton<ProfileSupabaseSource>(() => ProfileSupabaseSourceImpl());

  //* Inject Usecases
  di.registerLazySingleton(() => GetUserStreamUseCase(di()));
  di.registerLazySingleton(() => IsAuthenticatedUseCase(di()));
  di.registerLazySingleton(() => LoginUseCase(di()));
  di.registerLazySingleton(() => LogoutUseCase(di()));
  di.registerLazySingleton(() => RegisterUseCase(di()));
  di.registerLazySingleton(() => UpdateProfileUseCase(di()));
  di.registerLazySingleton(() => GetCurrentUserUseCase(di()));
  di.registerLazySingleton(() => UpdateCachedUserUseCase(di()));

  //* inject blocs
  di.registerLazySingleton(() => AuthBloc(
        authRepository: di(),
        getUserStreamUseCase: di(),
        isAuthenticatedUseCase: di(),
        logoutUseCase: di(),
      )..add(AuthStatusSubscriptionRequested()));
  di.registerFactory(() => LoginBloc(loginUseCase: di()));
  di.registerFactory(() => RegisterBloc(registerUseCase: di()));
  di.registerFactory(() => ProfileBloc(
        updateProfileUseCase: di(),
        getCurrentUserUseCase: di(),
      ));

  //* register routes and nav tabs
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(authRoutes());
}

void registerAuthModuleWithContext(BuildContext context) {
  //* Add all auth module navigation tabs
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getAuthNavTabs(context));
}
