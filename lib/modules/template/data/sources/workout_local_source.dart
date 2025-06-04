import 'package:hive/hive.dart';

import '../../../../_core/error/exceptions.dart';
import '../models/workout_model.dart';

abstract class WorkoutLocalSource {
  Future<void> saveWorkout(WorkoutModel workout);
  Future<List<WorkoutModel>> getWorkouts();
}

class WorkoutLocalSourceImpl implements WorkoutLocalSource {
  final Box<WorkoutModel> workoutBox;

  WorkoutLocalSourceImpl(this.workoutBox);

  @override
  Future<void> saveWorkout(WorkoutModel workout) {
    try {
      return workoutBox.put(workout.id, workout);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<WorkoutModel>> getWorkouts() {
    try {
      return Future.value(workoutBox.values.toList());
    } catch (e) {
      throw CacheException();
    }
  }
}
