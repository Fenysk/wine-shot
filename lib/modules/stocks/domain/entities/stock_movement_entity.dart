import 'package:equatable/equatable.dart';

enum StockMovementType {
  entry,
  exit,
  transform,
  inventory,
  transfer,
}

class StockMovement extends Equatable {
  final String id;
  final String wineId;
  final String? fromPackagingId;
  final String? toPackagingId;
  final String locationId;
  final int quantity;
  final StockMovementType movementType;
  final String? notes;
  final DateTime? createdAt;

  const StockMovement({
    required this.id,
    required this.wineId,
    this.fromPackagingId,
    this.toPackagingId,
    required this.locationId,
    required this.quantity,
    required this.movementType,
    this.notes,
    this.createdAt,
  });

  static const empty = StockMovement(
    id: '-',
    wineId: '-',
    locationId: '-',
    quantity: 0,
    movementType: StockMovementType.entry,
  );

  @override
  List<Object?> get props => [
        id,
        wineId,
        fromPackagingId,
        toPackagingId,
        locationId,
        quantity,
        movementType,
        notes,
        createdAt,
      ];
}
