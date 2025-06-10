import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../domain/entities/wine_stock_entity.dart';

class StocksTable extends StatelessWidget {
  final List<WineStockEntity> stocks;
  final Function(WineStockEntity) onDelete;

  const StocksTable({
    super.key,
    required this.stocks,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) {
      return _buildMobileView(context);
    }
    return _buildDesktopView(context);
  }

  Widget _buildDesktopView(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('wine.name'.tr())),
          DataColumn(label: Text('stock.packaging'.tr())),
          DataColumn(label: Text('stock.location'.tr())),
          DataColumn(label: Text('stock.quantity'.tr())),
          DataColumn(label: Text('actions'.tr())),
        ],
        rows: stocks.map((stock) => _buildStockRow(context, stock)).toList(),
      ),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(stock.wine?.name ?? '-'),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onDelete(stock),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow(context, 'stock.packaging'.tr(), stock.packaging?.label ?? '-'),
                _buildInfoRow(context, 'stock.location'.tr(), stock.location?.name ?? '-'),
                _buildInfoRow(context, 'stock.quantity'.tr(), stock.quantity.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  DataRow _buildStockRow(BuildContext context, WineStockEntity stock) {
    return DataRow(
      cells: [
        DataCell(Text(stock.wine?.name ?? '-')),
        DataCell(Text(stock.packaging?.label ?? '-')),
        DataCell(Text(stock.location?.name ?? '-')),
        DataCell(Text(stock.quantity.toString())),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(stock),
          ),
        ),
      ],
    );
  }
}
