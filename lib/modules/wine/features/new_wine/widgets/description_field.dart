import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'description',
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        labelText: context.tr('winesPage.newWineDialog.descriptionField.label'),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
