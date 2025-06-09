import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class WineNameField extends StatelessWidget {
  final TextEditingController controller;

  const WineNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'wine_name',
      controller: controller,
      decoration: InputDecoration(
        labelText: context.tr('winesPage.newWineDialog.wineNameField.label'),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.tr('winesPage.newWineDialog.wineNameField.validator');
        }
        return null;
      },
    );
  }
}
