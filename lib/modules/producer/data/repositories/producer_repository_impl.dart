import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../domain/entities/producer_entity.dart';
import '../../domain/repositories/producer_repository.dart';
import '../dto/new_producer_dto.dart';
import '../sources/producer_remote_source.dart';

class ProducerRepositoryImpl implements ProducerRepository {
  final ProducerRemoteSource remoteSource;

  ProducerRepositoryImpl({required this.remoteSource});

  @override
  Future<Either<Failure, List<ProducerEntity>>> getProducers() async {
    try {
      final producerModels = await remoteSource.getProducers();

      final producerEntities = producerModels
          .map((model) => ProducerEntity(
                id: model.id,
                name: model.name,
                regionId: model.regionId,
                region: model.region,
              ))
          .toList();

      return Right(producerEntities);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addProducer(NewProducerDto producer) async {
    try {
      await remoteSource.addProducer(producer);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProducer(String producerId) async {
    try {
      await remoteSource.deleteProducer(producerId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
