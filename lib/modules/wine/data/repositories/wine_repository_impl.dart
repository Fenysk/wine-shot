import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../data/dto/new_wine_dto.dart';
import '../../data/dto/update_wine_dto.dart';
import '../../domain/entities/wine_entity.dart';
import '../../domain/entities/wine_type_entity.dart';
import '../../domain/entities/grape_variety_entity.dart';
import '../../domain/entities/additional_information_entity.dart';
import '../../domain/repositories/wine_repository.dart';
import '../sources/wine_remote_source.dart';

class WineRepositoryImpl implements WineRepository {
  final WineRemoteSource remoteSource;

  WineRepositoryImpl({
    required this.remoteSource,
  });

  @override
  Future<Either<Failure, List<WineEntity>>> getWines() async {
    try {
      final wines = await remoteSource.getWines();

      return Right(wines);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WineEntity>> getWineById(String id) async {
    try {
      final wine = await remoteSource.getWineById(id);
      return Right(wine);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WineTypeEntity>>> getWineTypes() async {
    try {
      final wineTypes = await remoteSource.getWineTypes();
      return Right(wineTypes);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GrapeVarietyEntity>>> getGrapeVarieties() async {
    try {
      final grapeVarieties = await remoteSource.getGrapeVarieties();
      return Right(grapeVarieties);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AdditionalInformationEntity>>> getAdditionalInformations() async {
    try {
      final additionalInformations = await remoteSource.getAdditionalInformations();
      return Right(additionalInformations);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WineEntity>> createWine(NewWineDto wine) async {
    try {
      final result = await remoteSource.createWine(wine);
      return Right(result);
    } catch (error) {
      print(error);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WineEntity>> updateWine(UpdateWineDto wine) async {
    try {
      final result = await remoteSource.updateWine(wine);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteWine(String id) async {
    try {
      await remoteSource.deleteWine(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
