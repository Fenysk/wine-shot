part of 'new_producer_bloc.dart';

sealed class NewProducerEvent extends Equatable {
  const NewProducerEvent();

  @override
  List<Object> get props => [];
}

class AddProducerEvent extends NewProducerEvent {
  final ProducerEntity producer;

  const AddProducerEvent(this.producer);

  @override
  List<Object> get props => [
        producer
      ];
}
