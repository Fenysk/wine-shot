import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../bloc/profile_bloc.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> _editProfileFormKey;
  final ThemeData theme;

  const SubmitButton({super.key, required GlobalKey<FormBuilderState> editProfileFormKey, required this.theme}) : _editProfileFormKey = editProfileFormKey;

  void submitEditProfile(BuildContext context) {
    if (_editProfileFormKey.currentState?.saveAndValidate() ?? false) {
      final firstName = _editProfileFormKey.currentState?.fields['firstName']?.value;
      final lastName = _editProfileFormKey.currentState?.fields['lastName']?.value;
      final email = _editProfileFormKey.currentState?.fields['email']?.value;
      final phone = _editProfileFormKey.currentState?.fields['phone']?.value;

      BlocProvider.of<ProfileBloc>(context).add(UpdateProfile(firstName: firstName, lastName: lastName, email: email, phone: phone));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final bool isLoading = state is ProfileLoading;

        return ElevatedButton.icon(
          onPressed: isLoading ? null : () => submitEditProfile(context),
          icon: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.primaryColor,
                  ),
                )
              : Icon(Icons.check, size: 25, color: theme.primaryColor),
          label: Text('Submit', style: TextStyle(color: theme.primaryColor)),
        );
      },
    );
  }
}
