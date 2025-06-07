part of 'producer_bloc.dart';

sealed class ProducerState extends Equatable {
  const ProducerState();

  @override
  List<Object> get props => [];
}

class ProducerInitial extends ProducerState {}

class ProducerLoading extends ProducerState {}

class ProducerLoaded extends ProducerState {
  final List<ProducerEntity> producers;

  const ProducerLoaded({required this.producers});

  @override
  List<Object> get props => [
        producers
      ];
}

class ProducerError extends ProducerState {
  final String errorMessage;

  const ProducerError({required this.errorMessage});

  @override
  List<Object> get props => [
        errorMessage
      ];
}
