import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class VolumeField extends StatelessWidget {
  final TextEditingController controller;

  const VolumeField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'volume',
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(1000|[1-9]?\d{1,2})$'))
      ],
      decoration: InputDecoration(
        labelText: context.tr('winesPage.newWineDialog.volumeField.label'),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        final parsedValue = double.tryParse(value);

        if (parsedValue == null || parsedValue <= 0) {
          return context.tr('winesPage.newWineDialog.volumeField.validator.invalid');
        }

        return null;
      },
    );
  }
}
