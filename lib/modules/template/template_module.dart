import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../_core/constants.dart';
import '../../_core/di.dart';
import 'data/sources/workout_local_source.dart';
import 'data/models/workout_model.dart';
import 'data/repositories/workout_repository_impl.dart';
import 'domain/repositories/workout_repository.dart';
import 'domain/usecases/get_workouts_usecase.dart';
import 'domain/usecases/save_workout_usecase.dart';
import 'features/workout/bloc/workout_bloc.dart';
import 'template_routes.dart';

Future<void> registerTemplateModule() async {
  //* Enregistrer l'adaptateur Hive pour WorkoutModel
  if (!Hive.isAdapterRegistered(WorkoutModelAdapter().typeId)) {
    Hive.registerAdapter(WorkoutModelAdapter());
  }

  //* Register Hive Box
  if (!di.isRegistered<Box<WorkoutModel>>()) {
    final workoutBox = await Hive.openBox<WorkoutModel>('workouts');
    di.registerLazySingleton<Box<WorkoutModel>>(() => workoutBox);
  }

  //* Register Sources
  di.registerLazySingleton<WorkoutLocalSource>(
    () => WorkoutLocalSourceImpl(di()),
  );

  //* Register Repositories
  di.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(localDataSource: di()),
  );

  //* Register Use Cases
  di.registerLazySingleton(() => GetWorkoutsUseCase(di()));
  di.registerLazySingleton(() => SaveWorkoutUseCase(di(), Uuid()));

  //* Register Blocs
  di.registerFactory(
    () => WorkoutBloc(
      getWorkouts: di(),
      saveWorkout: di(),
    ),
  );

  //* register routes
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(templateRoutes());
}
