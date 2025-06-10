import '../../../../_core/supabase.dart';
import '../models/stock_movement_model.dart';
import '../models/wine_stock_model.dart';

abstract class StockRemoteSource {
  Future<List<WineStockModel>> getStocks();
  Future<List<StockMovementModel>> getMovements();
}

class StockRemoteSourceImpl implements StockRemoteSource {
  @override
  Future<List<WineStockModel>> getStocks() async {
    try {
      final response = await SupabaseConfig.client.from('wine_stocks').select('''
        *,
        wine:wines (*),
        packaging:packagings (*),
        location:locations (*)
      ''');

      final stocks = (response as List).map((stock) => WineStockModel.fromJson(stock)).toList();
      return stocks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StockMovementModel>> getMovements() async {
    try {
      final response = await SupabaseConfig.client.from('stock_movements').select('''
        *,
        wine:wines (*),
        from_packaging:packagings!from_packaging_id (*),
        to_packaging:packagings!to_packaging_id (*),
        from_location:locations!stock_movements_from_location_id_fkey (*),
        to_location:locations!stock_movements_to_location_id_fkey (*)
      ''');

      final movements = (response as List).map((movement) => StockMovementModel.fromJson(movement)).toList();
      return movements;
    } catch (e) {
      rethrow;
    }
  }
}
