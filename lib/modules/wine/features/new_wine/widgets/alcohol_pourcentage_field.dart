import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AlcoholPercentageField extends StatelessWidget {
  final TextEditingController controller;

  const AlcoholPercentageField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'alcohol_percentage',
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
      ],
      decoration: InputDecoration(
        labelText: context.tr('winesPage.newWineDialog.alcoholPercentageField.label'),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) return null;

        final parsedValue = double.tryParse(value);

        if (parsedValue == null || parsedValue < 0 || parsedValue > 100) {
          return context.tr('winesPage.newWineDialog.alcoholPercentageField.validator.invalid');
        }

        return null;
      },
    );
  }
}
