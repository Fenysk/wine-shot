import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/entities/wine_stock_entity.dart';
import '../../domain/repositories/stock_repository.dart';
import '../sources/stock_remote_source.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteSource remoteSource;

  StockRepositoryImpl({
    required this.remoteSource,
  });

  @override
  Future<Either<Failure, List<WineStockEntity>>> getStocks() async {
    try {
      final stocks = await remoteSource.getStocks();
      return Right(stocks);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<StockMovement>>> getMovements() async {
    try {
      final movements = await remoteSource.getMovements();
      return Right(movements);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
