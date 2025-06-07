import '../../../../_core/supabase.dart';
import '../../../../_shared/data/models/region_model.dart';

abstract class RegionRemoteSource {
  Future<List<RegionModel>> getRegions();
}

class RegionRemoteSourceImpl implements RegionRemoteSource {
  @override
  Future<List<RegionModel>> getRegions() async {
    final response = await SupabaseConfig.client.from('regions').select('*');

    final regions = (response as List).map((json) => RegionModel.fromJson(Map<String, dynamic>.from(json))).toList();

    return regions;
  }
}
