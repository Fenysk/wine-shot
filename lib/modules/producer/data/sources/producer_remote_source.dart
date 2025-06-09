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
      region:regions (*)
    ''');

    final producers = (response as List).map((producer) => ProducerModel.fromJson(producer as Map<String, dynamic>)).toList();

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
