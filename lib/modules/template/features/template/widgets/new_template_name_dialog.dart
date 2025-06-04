import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../_core/di.dart';
import '../../../../../_shared/widgets/custom_dialog.dart';
import '../bloc/template_bloc.dart';
import 'template_name_field.dart';

class NewTemplateNameDialog extends StatefulWidget {
  const NewTemplateNameDialog({
    super.key,
  });

  @override
  State<NewTemplateNameDialog> createState() => _NewTemplateNameDialogState();
}

class _NewTemplateNameDialogState extends State<NewTemplateNameDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: context.tr('templatesPage.newTemplate'),
      content: FormBuilder(
        key: _formKey,
        child: TemplateNameField(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.tr('common.cancel')),
        ),
        FilledButton(
          onPressed: () => _createTemplate(context),
          child: Text(context.tr('common.create')),
        ),
      ],
    );
  }

  void _createTemplate(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final templateName = _formKey.currentState?.fields['templateName']?.value;

      di<TemplateBloc>().add(CreateTemplateEvent(templateName: templateName));

      Navigator.pop(context);
    }
  }
}
