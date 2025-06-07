import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/producer_entity.dart';
import '../repositories/producer_repository.dart';

class GetProducersUsecase {
  final ProducerRepository repository;

  GetProducersUsecase({required this.repository});

  Future<Either<Failure, List<ProducerEntity>>> call() async {
    return await repository.getProducers();
  }
}
