import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../entities/wine_stock_entity.dart';

abstract class StockRepository {
  Future<Either<Failure, List<WineStockEntity>>> getStocks();
}
