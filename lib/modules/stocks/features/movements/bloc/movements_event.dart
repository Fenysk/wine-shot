part of 'movements_bloc.dart';

abstract class MovementsEvent extends Equatable {
  const MovementsEvent();

  @override
  List<Object> get props => [];
}

class LoadMovementsEvent extends MovementsEvent {
  const LoadMovementsEvent();
}
