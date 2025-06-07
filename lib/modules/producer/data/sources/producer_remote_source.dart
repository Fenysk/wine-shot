import '../../../../_core/supabase.dart';
import '../models/producer_model.dart';

abstract class ProducerRemoteSource {
  Future<List<ProducerModel>> getProducers();
  Future<ProducerModel> addProducer(ProducerModel producer);
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
  Future<ProducerModel> addProducer(ProducerModel producer) async {
    final response = await SupabaseConfig.client.from('producers').insert(producer).select('''
          *,
          regions (*)
        ''').single();

    final producerData = Map<String, dynamic>.from(response);
    final regionData = producerData['regions'] as Map<String, dynamic>?;

    if (regionData != null) {
      producerData['region'] = regionData;
    }

    return ProducerModel.fromJson(producerData);
  }
}
