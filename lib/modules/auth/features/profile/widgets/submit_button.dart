import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../bloc/profile_bloc.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> _editProfileFormKey;
  final ThemeData theme;
  final Function() onPressed;

  const SubmitButton({super.key, required GlobalKey<FormBuilderState> editProfileFormKey, required this.theme, required this.onPressed}) : _editProfileFormKey = editProfileFormKey;

  void submitEditProfile(BuildContext context) {
    if (_editProfileFormKey.currentState?.saveAndValidate() ?? false) {
      final firstName = _editProfileFormKey.currentState?.fields['firstName']?.value;

      BlocProvider.of<ProfileBloc>(context).add(UpdateFirstName(firstName: firstName));
    }
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => submitEditProfile(context),
      icon: Icon(Icons.check, size: 25, color: theme.primaryColor),
      label: Text('Submit', style: TextStyle(color: theme.primaryColor)),
    );
  }
}
