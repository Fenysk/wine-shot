import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../data/dto/new_wine_dto.dart';
import '../../data/dto/update_wine_dto.dart';
import '../entities/wine_entity.dart';
import '../entities/wine_type_entity.dart';
import '../entities/grape_variety_entity.dart';
import '../entities/additional_information_entity.dart';

abstract class WineRepository {
  Future<Either<Failure, List<WineEntity>>> getWines();
  Future<Either<Failure, WineEntity>> getWineById(String id);
  Future<Either<Failure, List<WineTypeEntity>>> getWineTypes();
  Future<Either<Failure, List<GrapeVarietyEntity>>> getGrapeVarieties();
  Future<Either<Failure, List<AdditionalInformationEntity>>> getAdditionalInformations();
  Future<Either<Failure, WineEntity>> createWine(NewWineDto wine);
  Future<Either<Failure, WineEntity>> updateWine(UpdateWineDto wine);
  Future<Either<Failure, void>> deleteWine(String id);
}
