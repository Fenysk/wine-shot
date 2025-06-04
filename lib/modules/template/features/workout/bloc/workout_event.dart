part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkoutsEvent extends WorkoutEvent {}

class SaveWorkoutEvent extends WorkoutEvent {
  final String name;

  const SaveWorkoutEvent({required this.name});

  @override
  List<Object> get props => [
        name
      ];
}
