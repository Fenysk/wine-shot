import 'package:equatable/equatable.dart';

import '../../../wine/domain/entities/wine_entity.dart';
import 'location_entity.dart';
import 'packaging_entity.dart';

class WineStockEntity extends Equatable {
  final String id;
  final String wineId;
  final String packagingId;
  final int quantity;
  final String? locationId;
  final WineEntity? wine;
  final PackagingEntity? packaging;
  final LocationEntity? location;

  const WineStockEntity({
    required this.id,
    required this.wineId,
    required this.packagingId,
    required this.quantity,
    this.locationId,
    this.wine,
    this.packaging,
    this.location,
  });

  static const empty = WineStockEntity(
    id: '-',
    wineId: '-',
    packagingId: '-',
    quantity: 0,
  );

  @override
  List<Object?> get props => [
        id,
        wineId,
        packagingId,
        quantity,
        locationId,
        wine,
        packaging,
        location,
      ];
}
