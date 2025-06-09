import 'package:equatable/equatable.dart';
import '../../../../_shared/domain/entities/region_entity.dart';
import '../../../producer/domain/entities/producer_entity.dart';
import 'wine_type_entity.dart';

class WineEntity extends Equatable {
  final String id;
  final String name;
  final double? alcoholPercentage;
  final int? volume;
  final String? description;
  final String? producerId;
  final String? regionId;
  final String? wineTypeId;
  final ProducerEntity? producer;
  final RegionEntity? region;
  final WineTypeEntity? wineType;

  const WineEntity({
    required this.id,
    required this.name,
    this.alcoholPercentage,
    this.volume,
    this.description,
    this.producerId,
    this.regionId,
    this.wineTypeId,
    this.producer,
    this.region,
    this.wineType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        alcoholPercentage,
        volume,
        description,
        producerId,
        regionId,
        wineTypeId,
        producer,
        region,
        wineType,
      ];
}
