import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/wine_stock_entity.dart';
import '../repositories/stock_repository.dart';

class GetStocksUseCase extends UseCase<List<WineStockEntity>, NoParams> {
  final StockRepository repository;

  GetStocksUseCase({required this.repository});

  @override
  Future<Either<Failure, List<WineStockEntity>>> call(NoParams params) async {
    return await repository.getStocks();
  }
}
