import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../data/dto/new_wine_dto.dart';
import '../repositories/wine_repository.dart';

class CreateWineUseCase {
  final WineRepository _repository;

  CreateWineUseCase({required WineRepository repository}) : _repository = repository;

  Future<Either<Failure, void>> call(NewWineDto wineDto) async {
    return await _repository.createWine(wineDto);
  }
}
