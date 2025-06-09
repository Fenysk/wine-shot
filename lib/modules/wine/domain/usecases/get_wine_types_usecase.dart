import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/wine_type_entity.dart';
import '../repositories/wine_repository.dart';

class GetWineTypesUseCase extends UseCase<List<WineTypeEntity>, NoParams> {
  final WineRepository repository;

  GetWineTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<WineTypeEntity>>> call(NoParams params) async {
    return await repository.getWineTypes();
  }
}
