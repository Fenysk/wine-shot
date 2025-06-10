import 'package:equatable/equatable.dart';

import '../../../wine/domain/entities/wine_entity.dart';
import 'location_entity.dart';
import 'packaging_entity.dart';

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
  final String? fromLocationId;
  final String? toLocationId;
  final int quantity;
  final StockMovementType movementType;
  final String? notes;
  final DateTime? createdAt;
  final WineEntity? wine;
  final PackagingEntity? fromPackaging;
  final PackagingEntity? toPackaging;
  final LocationEntity? fromLocation;
  final LocationEntity? toLocation;

  const StockMovement({
    required this.id,
    required this.wineId,
    this.fromPackagingId,
    this.toPackagingId,
    this.fromLocationId,
    this.toLocationId,
    required this.quantity,
    required this.movementType,
    this.notes,
    this.createdAt,
    this.wine,
    this.fromPackaging,
    this.toPackaging,
    this.fromLocation,
    this.toLocation,
  });

  static const empty = StockMovement(
    id: '-',
    wineId: '-',
    quantity: 0,
    movementType: StockMovementType.entry,
  );

  @override
  List<Object?> get props => [
        id,
        wineId,
        fromPackagingId,
        toPackagingId,
        fromLocationId,
        toLocationId,
        quantity,
        movementType,
        notes,
        createdAt,
        wine,
        fromPackaging,
        toPackaging,
        fromLocation,
        toLocation,
      ];
}
