import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProducerNameField extends StatelessWidget {
  final TextEditingController controller;

  const ProducerNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'producer_name',
      controller: controller,
      decoration: InputDecoration(
        labelText: context.tr('producersPage.newProducerDialog.producerNameField.label'),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.tr('producersPage.newProducerDialog.producerNameField.validator');
        }

        return null;
      },
    );
  }
}
