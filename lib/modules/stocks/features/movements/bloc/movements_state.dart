part of 'movements_bloc.dart';

abstract class MovementsState extends Equatable {
  const MovementsState();

  @override
  List<Object> get props => [];
}

class MovementsInitial extends MovementsState {
  const MovementsInitial();
}

class MovementsLoading extends MovementsState {
  const MovementsLoading();
}

class MovementsError extends MovementsState {
  final String errorMessage;

  const MovementsError({required this.errorMessage});

  @override
  List<Object> get props => [
        errorMessage
      ];
}

class MovementsLoaded extends MovementsState {
  final List<StockMovement> movements;

  const MovementsLoaded({required this.movements});

  @override
  List<Object> get props => [
        movements
      ];
}
