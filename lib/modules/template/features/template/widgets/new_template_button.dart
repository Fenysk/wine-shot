import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'new_template_name_dialog.dart';

class NewTemplateButton extends StatefulWidget {
  const NewTemplateButton({
    super.key,
  });

  @override
  State<NewTemplateButton> createState() => _NewTemplateButtonState();
}

class _NewTemplateButtonState extends State<NewTemplateButton> {
  void askNewTemplateName() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return NewTemplateNameDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return isMobile
        ? FloatingActionButton(
            onPressed: askNewTemplateName,
            child: const Icon(Icons.add),
          )
        : ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('New Template'),
            onPressed: askNewTemplateName,
          );
  }
}
