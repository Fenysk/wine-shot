import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_shared/widgets/custom_dialog.dart';
import '../bloc/workout_bloc.dart';
import 'workout_name_field.dart';

class NewWorkoutNameDialog extends StatefulWidget {
  const NewWorkoutNameDialog({
    super.key,
  });

  @override
  State<NewWorkoutNameDialog> createState() => _NewWorkoutNameDialogState();
}

class _NewWorkoutNameDialogState extends State<NewWorkoutNameDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<WorkoutBloc>(context),
      child: BlocListener<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutSavedSuccess) {
            Navigator.of(context).pop();
          } else if (state is WorkoutSavingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: CustomDialog(
          title: context.tr('templatesPage.newWorkout'),
          content: FormBuilder(
            key: _formKey,
            child: WorkoutNameField(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.tr('common.cancel')),
            ),
            FilledButton(
              onPressed: () => _createWorkout(context),
              child: Text(context.tr('common.create')),
            ),
          ],
        ),
      ),
    );
  }

  void _createWorkout(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final workoutName = _formKey.currentState?.fields['workoutName']?.value;

      if (workoutName != null && workoutName.isNotEmpty) {
        BlocProvider.of<WorkoutBloc>(context).add(SaveWorkoutEvent(name: workoutName));
      }
    }
  }
}
