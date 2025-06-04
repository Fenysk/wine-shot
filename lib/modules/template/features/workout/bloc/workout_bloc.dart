// ignore_for_file: unused_field

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/usecases/usecase.dart';
import '../../../domain/entities/workout_entity.dart';
import '../../../domain/usecases/get_workouts_usecase.dart';
import '../../../domain/usecases/save_workout_usecase.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutsUseCase getWorkouts;
  final SaveWorkoutUseCase saveWorkout;

  List<WorkoutEntity> _workouts = [];

  WorkoutBloc({
    required this.getWorkouts,
    required this.saveWorkout,
  }) : super(WorkoutInitial()) {
    on<LoadWorkoutsEvent>(_loadWorkouts);
    on<SaveWorkoutEvent>(_saveWorkout);
  }

  Future<void> _loadWorkouts(LoadWorkoutsEvent event, Emitter<WorkoutState> emit) async {
    emit(WorkoutLoading());

    final result = await getWorkouts(NoParams());

    result.fold(
      (failure) => emit(WorkoutError(failure.getMessage())),
      (workouts) async {
        _workouts = workouts;
        emit(WorkoutFetched(workouts: _workouts));
      },
    );
  }

  Future<void> _saveWorkout(SaveWorkoutEvent event, Emitter<WorkoutState> emit) async {
    emit(WorkoutSaving());
    final result = await saveWorkout(event.name);

    result.fold(
      (failure) => emit(WorkoutSavingError(failure.getMessage())),
      (_) {
        emit(WorkoutSavedSuccess());
        add(LoadWorkoutsEvent());
      },
    );
  }

  @override
  Future<void> close() {
    // No use cases to dispose of currently
    return super.close();
  }
}
