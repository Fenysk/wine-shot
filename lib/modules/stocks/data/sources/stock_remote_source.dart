import '../../../../_core/supabase.dart';
import '../models/wine_stock_model.dart';

abstract class StockRemoteSource {
  Future<List<WineStockModel>> getStocks();
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
}
