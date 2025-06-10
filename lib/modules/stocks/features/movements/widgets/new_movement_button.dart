import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewMovementButton extends StatelessWidget {
  const NewMovementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Implement new movement dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('movement.new.title'.tr()),
            content: Text('movement.new.content'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('common.cancel'.tr()),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement save movement
                  Navigator.of(context).pop();
                },
                child: Text('common.save'.tr()),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: Text('movement.new.button'.tr()),
    );
  }
}
