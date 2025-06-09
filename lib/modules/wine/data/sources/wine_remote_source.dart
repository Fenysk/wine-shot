import '../../../../_core/supabase.dart';
import '../models/wine_model.dart';
import '../models/wine_type_model.dart';
import '../models/grape_variety_model.dart';
import '../models/additional_information_model.dart';
import '../../domain/entities/wine_entity.dart';
import '../dto/new_wine_dto.dart';
import '../dto/update_wine_dto.dart';

abstract class WineRemoteSource {
  Future<List<WineEntity>> getWines();
  Future<WineEntity> getWineById(String id);
  Future<List<WineTypeModel>> getWineTypes();
  Future<List<GrapeVarietyModel>> getGrapeVarieties();
  Future<List<AdditionalInformationModel>> getAdditionalInformations();
  Future<WineEntity> createWine(NewWineDto wine);
  Future<WineEntity> updateWine(UpdateWineDto wine);
  Future<void> deleteWine(String id);
}

class WineRemoteSourceImpl implements WineRemoteSource {
  @override
  Future<List<WineEntity>> getWines() async {
    try {
      final response = await SupabaseConfig.client.from('wines').select('''
        *,
        producer:producers (*),
        region:regions (*),
        wine_type:wine_types(*)
    ''');

      final wines = (response as List).map((wine) => WineModel.fromJson(wine)).toList();
      return wines;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WineEntity> getWineById(String id) async {
    final response = await SupabaseConfig.client.from('wines').select('''
      *,
      producers (*)
    ''').eq('id', id).single();

    final wineData = Map<String, dynamic>.from(response);
    final producerData = wineData['producers'] as Map<String, dynamic>?;

    if (producerData != null) {
      wineData['producer'] = producerData;
    }

    return WineModel.fromJson(wineData);
  }

  @override
  Future<List<WineTypeModel>> getWineTypes() async {
    final response = await SupabaseConfig.client.from('wine_types').select('*');
    return (response as List).map((json) => WineTypeModel.fromJson(json)).toList();
  }

  @override
  Future<List<GrapeVarietyModel>> getGrapeVarieties() async {
    final response = await SupabaseConfig.client.from('grape_varieties').select('*');
    return (response as List).map((json) => GrapeVarietyModel.fromJson(json)).toList();
  }

  @override
  Future<List<AdditionalInformationModel>> getAdditionalInformations() async {
    final response = await SupabaseConfig.client.from('additional_informations').select('*');
    return (response as List).map((json) => AdditionalInformationModel.fromJson(json)).toList();
  }

  @override
  Future<WineEntity> createWine(NewWineDto wine) async {
    final response = await SupabaseConfig.client.from('wines').insert(wine.toJson()).select().single();
    return WineModel.fromJson(response);
  }

  @override
  Future<WineEntity> updateWine(UpdateWineDto wine) async {
    final response = await SupabaseConfig.client.from('wines').update(wine.toJson()).eq('id', wine.id).select().single();
    return WineModel.fromJson(response);
  }

  @override
  Future<void> deleteWine(String id) async {
    await SupabaseConfig.client.from('wines').delete().eq('id', id);
  }
}
