import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/region_entity.dart';
import '../../data/models/new_region_dto.dart';
import '../repositories/region_repository.dart';

class AddRegionUseCase {
  final RegionRepository repository;

  AddRegionUseCase({required this.repository});

  Future<Either<Failure, RegionEntity>> call(NewRegionDto dto) async {
    return await repository.createRegion(dto);
  }
}
