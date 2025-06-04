import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TemplateNameField extends StatelessWidget {
  const TemplateNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'templateName',
      decoration: InputDecoration(
        hintText: context.tr('templatesPage.templateNameHint'),
        border: const OutlineInputBorder(),
      ),
      autofocus: true,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: context.tr('common.requiredField')),
      ]),
    );
  }
}
