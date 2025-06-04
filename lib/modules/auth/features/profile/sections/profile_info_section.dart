import 'package:clean_starter/modules/auth/features/register/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di.dart';
import '../../../../../_shared/widgets/show_toast_notification.dart';
import '../../../domain/entities/user_entity.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/submit_button.dart';

class ProfileInfoSection extends StatefulWidget {
  final UserEntity user;
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
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return BlocProvider<ProfileBloc>(
      create: (context) => di(),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            setState(() {
              isEditMode = false;
            });
          }
          if (state is ProfileFailure) {
            CustomToast.showErrorNotification(
              title: "Registration Failed",
              description: state.errorMessage,
            );
          }
        },
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
                        ? ResponsiveRowColumn(
                            columnSpacing: 24,
                            rowSpacing: 8,
                            layout: isMobile ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
                            children: [
                              ResponsiveRowColumnItem(
                                rowFlex: 1,
                                child: FirstName(initialValue: widget.user.firstName),
                              ),
                              ResponsiveRowColumnItem(
                                rowFlex: 1,
                                child: LastName(initialValue: widget.user.lastName),
                              ),
                            ],
                          )
                        : Text(
                            '${widget.user.firstName} ${widget.user.lastName}',
                            style: widget.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                    const Divider(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        isEditMode ? EmailField(initialValue: widget.user.email) : _infoRow(Icons.email, widget.user.email, widget.theme.primaryColor),
                        isEditMode ? PhoneField(initialValue: widget.user.phone) : _infoRow(Icons.phone, widget.user.phone, widget.theme.primaryColor),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (isEditMode) ...[
                      SubmitButton(
                        editProfileFormKey: _editProfileFormKey,
                        theme: widget.theme,
                      ),
                      ElevatedButton.icon(
                        onPressed: toggleEditMode,
                        icon: Icon(Icons.cancel, size: 25, color: widget.theme.primaryColor),
                        label: Text('Cancel', style: TextStyle(color: widget.theme.primaryColor)),
                      ),
                    ] else
                      ElevatedButton.icon(
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
          value != '' ? value : 'No data',
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
