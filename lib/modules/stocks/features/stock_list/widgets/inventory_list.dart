import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/wine_stock_entity.dart';
import '../bloc/stocks_list_bloc.dart';
import 'new_stock_button.dart';
import 'stocks_table.dart';

class InventoryList extends StatelessWidget {
  final List<WineStockEntity> stocks;
  final Future<void> Function() onRefresh;

  const InventoryList({
    super.key,
    required this.stocks,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No stocks found'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const NewStockButton(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StocksTable(
          stocks: stocks,
          onDelete: (stock) => _showDeleteConfirmationDialog(context, stock),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, WineStockEntity stock) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Stock'.tr()),
        content: Text('Are you sure you want to delete this stock?'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              context.read<StocksListBloc>().add(DeleteStockEvent(stockId: stock.id));
              Navigator.of(context).pop();
            },
            child: Text(
              'Delete'.tr(),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
