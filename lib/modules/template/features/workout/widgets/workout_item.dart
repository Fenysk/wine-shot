import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/workout_entity.dart';

class WorkoutItem extends StatelessWidget {
  const WorkoutItem({
    super.key,
    required this.workout,
  });

  final WorkoutEntity workout;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workout.name),
      onTap: () {
        context.go('/templates/${workout.id}');
      },
    );
  }
}
