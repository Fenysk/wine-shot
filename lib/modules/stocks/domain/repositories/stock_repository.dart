import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../entities/stock_movement_entity.dart';
import '../entities/wine_stock_entity.dart';

abstract class StockRepository {
  Future<Either<Failure, List<WineStockEntity>>> getStocks();
  Future<Either<Failure, List<StockMovement>>> getMovements();
}
