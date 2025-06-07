import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../domain/entities/producer_entity.dart';
import '../../domain/repositories/producer_repository.dart';
import '../models/producer_model.dart';
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
  @override
  Future<Either<Failure, ProducerEntity>> addProducer(ProducerEntity producer) async {
    try {
      final newProducerModel = ProducerModel.fromJson({
        "name": producer.name,
        "regionId": producer.regionId,
      });

      final producerModel = await remoteSource.addProducer(newProducerModel);
      final producerEntity = ProducerEntity(
        id: producerModel.id,
        name: producerModel.name,
        regionId: producerModel.regionId,
        region: producerModel.region,
      );
      return Right(producerEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
