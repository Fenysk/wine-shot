import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecases/usecase.dart';
import '../../../domain/entities/wine_stock_entity.dart';
import '../../../domain/usecases/get_stocks_usecase.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetStocksUseCase getStocksUseCase;

  InventoryBloc({required this.getStocksUseCase}) : super(const InventoryInitial()) {
    on<LoadInventoryEvent>(_onLoadInventory);
  }

  Future<void> _onLoadInventory(
    LoadInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(const InventoryLoading());

    final result = await getStocksUseCase(NoParams());

    result.fold(
      (failure) => emit(InventoryError(errorMessage: 'Failed to load inventory')),
      (stocks) => emit(InventoryLoaded(stocks: stocks)),
    );
  }
}
