import 'package:flutter/material.dart';

class NewStockButton extends StatelessWidget {
  const NewStockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Implement new stock dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('New Stock'),
            content: const Text('New stock dialog will be implemented here.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement save stock
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('Add Stock'),
    );
  }
}
