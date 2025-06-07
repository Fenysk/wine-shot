part of 'new_producer_bloc.dart';

sealed class NewProducerState extends Equatable {
  const NewProducerState();

  @override
  List<Object> get props => [];
}

class NewProducerInitial extends NewProducerState {}

class NewProducerLoading extends NewProducerState {}

class NewProducerSuccess extends NewProducerState {
  final ProducerEntity producer;

  const NewProducerSuccess({required this.producer});

  @override
  List<Object> get props => [
        producer
      ];
}

class NewProducerFailure extends NewProducerState {
  final String message;

  const NewProducerFailure({required this.message});

  @override
  List<Object> get props => [
        message
      ];
}
