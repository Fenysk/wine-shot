import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/stock_movement_entity.dart';
import '../repositories/stock_repository.dart';

class GetMovementsUseCase extends UseCase<List<StockMovement>, NoParams> {
  final StockRepository repository;

  GetMovementsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<StockMovement>>> call(NoParams params) async {
    return await repository.getMovements();
  }
}
