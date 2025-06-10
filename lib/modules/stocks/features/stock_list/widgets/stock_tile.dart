import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../domain/entities/wine_stock_entity.dart';
import '../bloc/stocks_list_bloc.dart';

enum StockTileDisplayType {
  card,
  tile
}

class StockTile extends StatelessWidget {
  const StockTile({
    super.key,
    required this.stock,
    this.displayType = StockTileDisplayType.card,
  });

  final WineStockEntity stock;
  final StockTileDisplayType displayType;

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case StockTileDisplayType.card:
        return _buildCard(context);
      case StockTileDisplayType.tile:
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
                  stock.wine?.name ?? context.tr('wine.unknown'),
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                if (stock.packaging != null)
                  Text(
                    stock.packaging!.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (stock.location != null)
                  Text(
                    stock.location!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                Text(
                  '${context.tr('stock.quantity')}: ${stock.quantity}',
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
          stock.wine?.name ?? context.tr('wine.unknown'),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (stock.packaging != null)
              Text(
                stock.packaging!.label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            if (stock.location != null)
              Text(
                stock.location!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            Text(
              '${context.tr('stock.quantity')}: ${stock.quantity}',
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
        title: Text(context.tr('stock.delete.title')),
        content: Text(context.tr('stock.delete.confirmation')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('common.cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<StocksListBloc>().add(DeleteStockEvent(stockId: stock.id));
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
