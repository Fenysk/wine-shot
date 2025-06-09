import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/wine_entity.dart';
import '../repositories/wine_repository.dart';

class GetWinesUseCase extends UseCase<List<WineEntity>, NoParams> {
  final WineRepository repository;

  GetWinesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<WineEntity>>> call(NoParams params) async {
    return await repository.getWines();
  }
}
