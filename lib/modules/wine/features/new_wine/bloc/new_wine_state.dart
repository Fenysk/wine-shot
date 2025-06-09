part of 'new_wine_bloc.dart';

enum NewWineStatus {
  initial,
  loading,
  success,
  failure
}

class NewWineState extends Equatable {
  final NewWineStatus status;
  final String? errorMessage;

  const NewWineState({
    this.status = NewWineStatus.initial,
    this.errorMessage,
  });

  factory NewWineState.initial() => const NewWineState();

  factory NewWineState.loading() => const NewWineState(
        status: NewWineStatus.loading,
      );

  factory NewWineState.success() => const NewWineState(
        status: NewWineStatus.success,
      );

  factory NewWineState.failure(String message) => NewWineState(
        status: NewWineStatus.failure,
        errorMessage: message,
      );

  @override
  List<Object?> get props => [
        status,
        errorMessage
      ];
}
