import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/workout_entity.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutsUseCase implements UseCase<List<WorkoutEntity>, NoParams> {
  final WorkoutRepository repository;

  GetWorkoutsUseCase(this.repository);

  @override
  Future<Either<Failure, List<WorkoutEntity>>> call(NoParams params) async {
    return await repository.getWorkouts();
  }
}
