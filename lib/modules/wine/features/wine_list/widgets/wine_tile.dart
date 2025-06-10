import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/wine_entity.dart';
import '../../wine_list/bloc/wine-list/wine_list_bloc.dart';
import '../../wine_list/bloc/wine-list/wine_list_event.dart';
import 'wine_list.dart';

class WineTile extends StatelessWidget {
  const WineTile({
    super.key,
    required this.wine,
    this.displayType = WineTileDisplayType.card,
  });

  final WineEntity wine;
  final WineTileDisplayType displayType;

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case WineTileDisplayType.card:
        return _buildCard(context);
      case WineTileDisplayType.tile:
        return _buildTile(context);
    }
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: [
                Text(
                  wine.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                if (wine.wineType != null || wine.alcoholPercentage != null)
                  Text(
                    [
                      if (wine.wineType != null) wine.wineType!.label,
                      if (wine.alcoholPercentage != null) '${wine.alcoholPercentage}%',
                    ].join(' • '),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (wine.region != null)
                  Text(
                    wine.region!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (wine.producer != null)
                  Text(
                    wine.producer!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                _showDeleteConfirmationDialog(context, wine.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(
          wine.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (wine.producer != null)
              Text(
                wine.producer!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            if (wine.region != null)
              Text(
                wine.region!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            if (wine.wineType != null || wine.alcoholPercentage != null)
              Text(
                [
                  if (wine.wineType != null) wine.wineType!.label,
                  if (wine.alcoholPercentage != null) '${wine.alcoholPercentage}%',
                ].join(' • '),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: () {
            _showDeleteConfirmationDialog(context, wine.id);
          },
        ),
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
