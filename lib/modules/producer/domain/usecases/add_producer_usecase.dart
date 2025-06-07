import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../domain/entities/producer_entity.dart';
import '../repositories/producer_repository.dart';

class AddProducerUsecase {
  final ProducerRepository repository;

  AddProducerUsecase({required this.repository});

  Future<Either<Failure, ProducerEntity>> call(ProducerEntity params) async {
    return await repository.addProducer(params);
  }
}
