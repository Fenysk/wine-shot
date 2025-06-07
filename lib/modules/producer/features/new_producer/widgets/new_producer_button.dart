import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'new_producer_dialog.dart';

class NewProducerButton extends StatelessWidget {
  const NewProducerButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return isMobile
        ? FloatingActionButton(
            onPressed: () => showNewProducerDialog(context),
            child: const Icon(Icons.add),
          )
        : TextButton.icon(
            onPressed: () => showNewProducerDialog(context),
            icon: const Icon(Icons.add),
            label: const Text("Nouveau producteur"),
          );
  }

  void showNewProducerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NewProducerDialog();
      },
    );
  }
}
