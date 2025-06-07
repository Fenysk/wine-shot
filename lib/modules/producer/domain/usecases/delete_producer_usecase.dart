import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../repositories/producer_repository.dart';

class DeleteProducerUsecase extends UseCase<void, String> {
  final ProducerRepository repository;

  DeleteProducerUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(String producerId) async {
    return await repository.deleteProducer(producerId);
  }
}
