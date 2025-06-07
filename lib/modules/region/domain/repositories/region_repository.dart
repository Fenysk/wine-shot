import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/region_entity.dart';

abstract class RegionRepository {
  Future<Either<Failure, List<RegionEntity>>> getRegions();
}
