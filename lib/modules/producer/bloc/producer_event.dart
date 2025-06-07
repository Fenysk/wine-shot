part of 'producer_bloc.dart';

sealed class ProducerEvent extends Equatable {
  const ProducerEvent();

  @override
  List<Object> get props => [];
}

class LoadProducersEvent extends ProducerEvent {}

class DeleteProducerEvent extends ProducerEvent {
  final String producerId;

  const DeleteProducerEvent(this.producerId);

  @override
  List<Object> get props => [
        producerId
      ];
}
