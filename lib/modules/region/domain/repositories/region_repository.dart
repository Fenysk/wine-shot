import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/region_entity.dart';
import '../../data/models/new_region_dto.dart';

abstract class RegionRepository {
  Future<Either<Failure, List<RegionEntity>>> getRegions();
  Future<Either<Failure, RegionEntity>> createRegion(NewRegionDto region);
}
