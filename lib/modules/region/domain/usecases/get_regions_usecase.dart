import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/region_entity.dart';
import '../repositories/region_repository.dart';

class GetRegionsUsecase {
  final RegionRepository repository;
  GetRegionsUsecase({required this.repository});

  Future<Either<Failure, List<RegionEntity>>> call() async {
    return await repository.getRegions();
  }
}
