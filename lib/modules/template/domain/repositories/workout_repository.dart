import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/workout_entity.dart';

abstract class WorkoutRepository {
  Future<Either<Failure, String>> saveWorkout(WorkoutEntity workout);
  Future<Either<Failure, List<WorkoutEntity>>> getWorkouts();
  void dispose();
}
