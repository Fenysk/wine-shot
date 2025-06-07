import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../repositories/producer_repository.dart';
import '../../data/dto/new_producer_dto.dart';

class AddProducerUsecase extends UseCase<void, NewProducerDto> {
  final ProducerRepository repository;

  AddProducerUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NewProducerDto params) async {
    return await repository.addProducer(params);
  }
}
