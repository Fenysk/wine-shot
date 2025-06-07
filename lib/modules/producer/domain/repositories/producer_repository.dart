import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/producer_entity.dart';
import '../../data/dto/new_producer_dto.dart';

abstract class ProducerRepository {
  Future<Either<Failure, List<ProducerEntity>>> getProducers();
  Future<Either<Failure, void>> addProducer(NewProducerDto producer);
  Future<Either<Failure, void>> deleteProducer(String producerId);
}
