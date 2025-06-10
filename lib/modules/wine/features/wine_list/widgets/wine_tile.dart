import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/wine_entity.dart';
import '../../wine_list/bloc/wine-list/wine_list_bloc.dart';
import '../../wine_list/bloc/wine-list/wine_list_event.dart';

class WineTile extends StatelessWidget {
  const WineTile({
    super.key,
    required this.wine,
  });

  final WineEntity wine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        wine.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (wine.producer != null || wine.region != null)
            Text(
              [
                if (wine.producer != null) wine.producer!.name,
                if (wine.region != null) wine.region!.name,
              ].join(' · '),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          if (wine.wineType != null)
            Text(
              wine.wineType!.label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          _showDeleteConfirmationDialog(context, wine.id);
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, String wineId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le vin'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce vin ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (context.mounted) {
        context.read<WineListBloc>().add(DeleteWineEvent(wineId: wineId));
      }
    }
  }
}
