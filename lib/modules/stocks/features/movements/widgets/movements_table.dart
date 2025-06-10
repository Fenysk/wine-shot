import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../domain/entities/stock_movement_entity.dart';

class MovementsTable extends StatelessWidget {
  final List<StockMovement> movements;

  const MovementsTable({
    super.key,
    required this.movements,
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
          DataColumn(label: Text('movement.table.wine'.tr())),
          DataColumn(label: Text('movement.table.type'.tr())),
          DataColumn(label: Text('movement.table.packaging'.tr())),
          DataColumn(label: Text('movement.table.fromLocation'.tr())),
          DataColumn(label: Text('movement.table.toLocation'.tr())),
          DataColumn(label: Text('movement.table.quantity'.tr())),
          DataColumn(label: Text('movement.table.date'.tr())),
        ],
        rows: movements.map((movement) => _buildMovementRow(context, movement)).toList(),
      ),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return ListView.builder(
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final movement = movements[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movement.wine?.name ?? '-',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(context, 'movement.table.type'.tr(), _getMovementTypeLabel(movement.movementType)),
                _buildInfoRow(context, 'movement.table.packaging'.tr(), _getPackagingLabel(movement)),
                _buildInfoRow(context, 'movement.table.fromLocation'.tr(), movement.fromLocation?.name ?? '-'),
                _buildInfoRow(context, 'movement.table.toLocation'.tr(), movement.toLocation?.name ?? '-'),
                _buildInfoRow(context, 'movement.table.quantity'.tr(), movement.quantity.toString()),
                _buildInfoRow(context, 'movement.table.date'.tr(), movement.createdAt?.toString() ?? '-'),
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

  DataRow _buildMovementRow(BuildContext context, StockMovement movement) {
    return DataRow(
      cells: [
        DataCell(Text(movement.wine?.name ?? '-')),
        DataCell(Text(_getMovementTypeLabel(movement.movementType))),
        DataCell(Text(_getPackagingLabel(movement))),
        DataCell(Text(movement.fromLocation?.name ?? '-')),
        DataCell(Text(movement.toLocation?.name ?? '-')),
        DataCell(Text(movement.quantity.toString())),
        DataCell(Text(movement.createdAt?.toString() ?? '-')),
      ],
    );
  }

  String _getMovementTypeLabel(StockMovementType type) {
    switch (type) {
      case StockMovementType.entry:
        return 'movement.type.entry'.tr();
      case StockMovementType.exit:
        return 'movement.type.exit'.tr();
      case StockMovementType.transform:
        return 'movement.type.transform'.tr();
      case StockMovementType.inventory:
        return 'movement.type.inventory'.tr();
      case StockMovementType.transfer:
        return 'movement.type.transfer'.tr();
    }
  }

  String _getPackagingLabel(StockMovement movement) {
    if (movement.movementType == StockMovementType.transform) {
      return '${movement.fromPackaging?.label ?? '-'} → ${movement.toPackaging?.label ?? '-'}';
    }
    return movement.fromPackaging?.label ?? movement.toPackaging?.label ?? '-';
  }
}
