part of 'new_producer_bloc.dart';

enum NewProducerStatus {
  initial,
  loading,
  success,
  failure
}

class NewProducerState extends Equatable {
  final NewProducerStatus status;
  final String? errorMessage;

  const NewProducerState({
    this.status = NewProducerStatus.initial,
    this.errorMessage,
  });

  factory NewProducerState.initial() => const NewProducerState();

  factory NewProducerState.loading() => const NewProducerState(
        status: NewProducerStatus.loading,
      );

  factory NewProducerState.success() => const NewProducerState(
        status: NewProducerStatus.success,
      );

  factory NewProducerState.failure(String message) => NewProducerState(
        status: NewProducerStatus.failure,
        errorMessage: message,
      );

  @override
  List<Object?> get props => [
        status,
        errorMessage
      ];
}
