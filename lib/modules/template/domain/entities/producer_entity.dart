import 'package:equatable/equatable.dart';

import '../../../../_shared/domain/entities/region_entity.dart';

class ProducerEntity extends Equatable {
  final String id;
  final String name;
  final String regionId;
  final RegionEntity? region;

  const ProducerEntity({
    required this.id,
    required this.name,
    required this.regionId,
    this.region,
  });

  static const empty = ProducerEntity(id: '', name: '', regionId: '', region: RegionEntity.empty);

  @override
  List<Object> get props => [
        id,
        name,
        regionId,
      ];
}
