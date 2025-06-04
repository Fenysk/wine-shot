import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workout_bloc.dart';
import 'new_workout_dialog.dart';

class NewWorkoutButton extends StatefulWidget {
  const NewWorkoutButton({
    super.key,
  });

  @override
  State<NewWorkoutButton> createState() => _NewWorkoutButtonState();
}

class _NewWorkoutButtonState extends State<NewWorkoutButton> {
  void openNewWorkoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<WorkoutBloc>(context),
          child: NewWorkoutDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return isMobile
        ? FloatingActionButton(
            onPressed: openNewWorkoutDialog,
            child: const Icon(Icons.add),
          )
        : ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('New Template'),
            onPressed: openNewWorkoutDialog,
          );
  }
}
