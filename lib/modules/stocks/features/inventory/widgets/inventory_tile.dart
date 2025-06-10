import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../domain/entities/wine_stock_entity.dart';
import '../bloc/inventory_bloc.dart';

enum InventoryTileDisplayType {
  card,
  tile
}

class InventoryTile extends StatelessWidget {
  const InventoryTile({
    super.key,
    required this.item,
    this.displayType = InventoryTileDisplayType.card,
  });

  final WineStockEntity item;
  final InventoryTileDisplayType displayType;

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case InventoryTileDisplayType.card:
        return _buildCard(context);
      case InventoryTileDisplayType.tile:
        return _buildTile(context);
    }
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4.0,
              children: [
                Text(
                  item.wine?.name ?? context.tr('wine.unknown'),
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                if (item.packaging != null)
                  Text(
                    item.packaging!.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (item.location != null)
                  Text(
                    item.location!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                Text(
                  '${context.tr('inventory.quantity')}: ${item.quantity}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(
          item.wine?.name ?? context.tr('wine.unknown'),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.packaging != null)
              Text(
                item.packaging!.label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            if (item.location != null)
              Text(
                item.location!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            Text(
              '${context.tr('inventory.quantity')}: ${item.quantity}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: () {
            _showDeleteConfirmationDialog(context);
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.tr('inventory.delete.title')),
        content: Text(context.tr('inventory.delete.confirmation')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('common.cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<InventoryBloc>().add(DeleteInventoryEvent(itemStockId: item.id));
              Navigator.of(context).pop();
            },
            child: Text(
              context.tr('common.delete'),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
