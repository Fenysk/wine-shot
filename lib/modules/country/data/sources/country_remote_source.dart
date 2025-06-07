import '../../../../_core/supabase.dart';
import '../models/country_model.dart';

abstract class CountryRemoteSource {
  Future<List<CountryModel>> getCountries();
}

class CountryRemoteSourceImpl implements CountryRemoteSource {
  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await SupabaseConfig.client.from('countries').select('*');
    return (response as List).map((json) => CountryModel.fromJson(Map<String, dynamic>.from(json))).toList();
  }
}
