part of 'workout_bloc.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError(this.message);

  @override
  List<Object> get props => [
        message
      ];
}

class WorkoutFetched extends WorkoutState {
  final List<WorkoutEntity> workouts;

  const WorkoutFetched({required this.workouts});

  WorkoutFetched copyWith({
    List<WorkoutEntity>? workouts,
  }) {
    return WorkoutFetched(
      workouts: workouts ?? this.workouts,
    );
  }

  @override
  List<Object> get props => [
        workouts
      ];
}

class WorkoutSaving extends WorkoutState {}

class WorkoutSavedSuccess extends WorkoutState {}

class WorkoutSavingError extends WorkoutState {
  final String message;

  const WorkoutSavingError(this.message);

  @override
  List<Object> get props => [
        message
      ];
}
