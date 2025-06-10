import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/stock_movement_entity.dart';
import '../bloc/movements_bloc.dart';
import 'new_movement_button.dart';
import 'movements_table.dart';

class MovementsList extends StatelessWidget {
  final List<StockMovement> movements;
  final Future<void> Function() onRefresh;

  const MovementsList({
    super.key,
    required this.movements,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (movements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No movements found'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const NewMovementButton(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MovementsTable(
          movements: movements,
        ),
      ),
    );
  }
}
