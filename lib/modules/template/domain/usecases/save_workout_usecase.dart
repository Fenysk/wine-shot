import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/workout_entity.dart';
import '../repositories/workout_repository.dart';

class SaveWorkoutUseCase implements UseCase<void, String> {
  final WorkoutRepository repository;
  final Uuid uuid;

  SaveWorkoutUseCase(this.repository, this.uuid);

  @override
  Future<Either<Failure, void>> call(String name) async {
    final workout = WorkoutEntity(
      id: uuid.v4(),
      name: name,
    );
    return await repository.saveWorkout(workout);
  }
}
