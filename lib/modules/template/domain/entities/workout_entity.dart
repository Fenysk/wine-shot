import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
  final String id;
  final String name;

  const WorkoutEntity({
    required this.id,
    required this.name,
  });

  static const empty = WorkoutEntity(id: '', name: '');

  @override
  List<Object?> get props => [
        id,
        name
      ];
}
