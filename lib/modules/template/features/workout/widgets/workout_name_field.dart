import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class WorkoutNameField extends StatelessWidget {
  const WorkoutNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'workoutName',
      decoration: InputDecoration(
        hintText: context.tr('templatesPage.workoutNameNameHint'),
        border: const OutlineInputBorder(),
      ),
      autofocus: true,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: context.tr('common.requiredField')),
      ]),
    );
  }
}
