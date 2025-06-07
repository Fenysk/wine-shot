part of 'new_producer_bloc.dart';

abstract class NewProducerEvent extends Equatable {
  const NewProducerEvent();

  @override
  List<Object?> get props => [];
}

class AddProducerEvent extends NewProducerEvent {
  final NewProducerDto producerDto;

  const AddProducerEvent(this.producerDto);

  @override
  List<Object?> get props => [
        producerDto
      ];
}
