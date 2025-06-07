import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/producer_entity.dart';

abstract class ProducerRepository {
  Future<Either<Failure, List<ProducerEntity>>> getProducers();
  Future<Either<Failure, ProducerEntity>> addProducer(ProducerEntity producer);
}
