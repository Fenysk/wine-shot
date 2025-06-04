import 'package:dartz/dartz.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/entities/workout_entity.dart';
import '../../domain/repositories/workout_repository.dart';
import '../sources/workout_local_source.dart';
import '../models/workout_model.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutLocalSource localDataSource;

  WorkoutRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, String>> saveWorkout(WorkoutEntity workout) async {
    try {
      final workoutModel = WorkoutModel(id: workout.id, name: workout.name);
      await localDataSource.saveWorkout(workoutModel);
      return Right(workoutModel.id);
    } on CacheException {
      return Left(CacheFailure('Failed to save workout locally'));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WorkoutEntity>>> getWorkouts() async {
    try {
      final workoutModels = await localDataSource.getWorkouts();
      // Convertir la liste de modèles en liste d'entités
      final workoutEntities = workoutModels.map((model) => WorkoutEntity(id: model.id, name: model.name)).toList();
      return Right(workoutEntities);
    } on CacheException {
      return Left(CacheFailure('Failed to retrieve workouts locally'));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  void dispose() {}
}
