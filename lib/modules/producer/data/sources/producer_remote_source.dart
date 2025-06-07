import '../../../../_core/supabase.dart';
import '../dto/new_producer_dto.dart';
import '../models/producer_model.dart';

abstract class ProducerRemoteSource {
  Future<List<ProducerModel>> getProducers();
  Future<void> addProducer(NewProducerDto producer);
  Future<void> deleteProducer(String producerId);
}

class ProducerRemoteSourceImpl implements ProducerRemoteSource {
  @override
  Future<List<ProducerModel>> getProducers() async {
    final response = await SupabaseConfig.client.from('producers').select('''
      *,
      regions (*)
    ''');

    final producers = (response as List).map((producer) {
      final producerData = Map<String, dynamic>.from(producer);
      final regionData = producerData['regions'] as Map<String, dynamic>?;

      if (regionData != null) {
        producerData['region'] = regionData;
      }

      return ProducerModel.fromJson(producerData);
    }).toList();

    return producers;
  }

  @override
  Future<void> addProducer(NewProducerDto producer) async {
    await SupabaseConfig.client.from('producers').insert(producer.toJson());
  }

  @override
  Future<void> deleteProducer(String producerId) async {
    await SupabaseConfig.client.from('producers').delete().eq('id', producerId);
  }
}
