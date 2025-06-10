import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecases/usecase.dart';
import '../../../domain/entities/stock_movement_entity.dart';
import '../../../domain/usecases/get_movements_usecase.dart';

part 'movements_event.dart';
part 'movements_state.dart';

class MovementsBloc extends Bloc<MovementsEvent, MovementsState> {
  final GetMovementsUseCase getMovementsUseCase;

  MovementsBloc({required this.getMovementsUseCase}) : super(const MovementsInitial()) {
    on<LoadMovementsEvent>(_onLoadMovements);
  }

  Future<void> _onLoadMovements(
    LoadMovementsEvent event,
    Emitter<MovementsState> emit,
  ) async {
    emit(const MovementsLoading());

    final result = await getMovementsUseCase(NoParams());

    result.fold(
      (failure) => emit(MovementsError(errorMessage: 'Failed to load movements')),
      (movements) => emit(MovementsLoaded(movements: movements)),
    );
  }
}
