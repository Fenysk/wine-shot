import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../repositories/wine_repository.dart';

class DeleteWineUseCase extends UseCase<void, String> {
  final WineRepository repository;

  DeleteWineUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(String wineId) async {
    return await repository.deleteWine(wineId);
  }
}
