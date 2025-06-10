import '../../../../_core/supabase.dart';
import '../../../../_shared/data/models/region_model.dart';
import '../../../../_shared/domain/entities/region_entity.dart';
import '../models/new_region_dto.dart';

abstract class RegionRemoteSource {
  Future<List<RegionModel>> getRegions();
  Future<RegionEntity> createRegion(NewRegionDto region);
}

class RegionRemoteSourceImpl implements RegionRemoteSource {
  @override
  Future<List<RegionModel>> getRegions() async {
    final response = await SupabaseConfig.client.from('regions').select('*');

    final regions = (response as List).map((json) => RegionModel.fromJson(Map<String, dynamic>.from(json))).toList();

    return regions;
  }

  @override
  Future<RegionEntity> createRegion(NewRegionDto dto) async {
    final response = await SupabaseConfig.client.from('regions').insert(dto.toJson()).select();

    final newRegion = RegionModel.fromJson(Map<String, dynamic>.from(response[0]));

    return newRegion;
  }
}
