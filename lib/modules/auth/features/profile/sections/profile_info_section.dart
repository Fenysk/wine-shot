import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../_core/di.dart';
import '../../../domain/user.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/submit_button.dart';
import '../widgets/widgets.dart';

class ProfileInfoSection extends StatefulWidget {
  final User user;
  final ThemeData theme;

  const ProfileInfoSection({super.key, required this.user, required this.theme});

  @override
  State<ProfileInfoSection> createState() => _ProfileInfoSectionState();
}

class _ProfileInfoSectionState extends State<ProfileInfoSection> {
  final _editProfileFormKey = GlobalKey<FormBuilderState>();

  bool isEditMode = false;

  void toggleEditMode() => setState(() => isEditMode = !isEditMode);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => di(),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: FormBuilder(
              key: _editProfileFormKey,
              child: Column(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: widget.theme.primaryColor.withValues(alpha: 0.1),
                    child: Icon(Icons.person, size: 60, color: widget.theme.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  isEditMode
                      ? FirstNameField(initialValue: widget.user.firstName)
                      : Text(
                          '${widget.user.firstName} ${widget.user.lastName}',
                          style: widget.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                  Text('User ID: ${widget.user.id}', style: widget.theme.textTheme.bodySmall),
                  const SizedBox(height: 8),
                  const Divider(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      _infoRow(Icons.email, widget.user.email, widget.theme.primaryColor),
                      _infoRow(Icons.phone, widget.user.phone, widget.theme.primaryColor),
                    ],
                  ),
                  const SizedBox(height: 30),
                  isEditMode
                      ? SubmitButton(
                          editProfileFormKey: _editProfileFormKey,
                          theme: widget.theme,
                          onPressed: toggleEditMode,
                        )
                      : ElevatedButton.icon(
                          onPressed: toggleEditMode,
                          icon: Icon(Icons.edit, size: 25, color: widget.theme.primaryColor),
                          label: Text('Edit', style: TextStyle(color: widget.theme.primaryColor)),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 25, color: color),
        const SizedBox(width: 20),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
