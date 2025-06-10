import 'package:clean_starter/modules/region/data/models/new_region_dto.dart';
import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/region_entity.dart';
import '../../domain/repositories/region_repository.dart';
import '../sources/region_remote_source.dart';

class RegionRepositoryImpl implements RegionRepository {
  final RegionRemoteSource remoteSource;
  RegionRepositoryImpl({required this.remoteSource});

  @override
  Future<Either<Failure, List<RegionEntity>>> getRegions() async {
    try {
      final models = await remoteSource.getRegions();
      return Right(models);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RegionEntity>> createRegion(NewRegionDto dto) async {
    try {
      final newRegion = await remoteSource.createRegion(dto);
      return Right(newRegion);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
