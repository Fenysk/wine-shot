import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecases/usecase.dart';
import '../../../domain/entities/wine_stock_entity.dart';
import '../../../domain/usecases/get_stocks_usecase.dart';

part 'stocks_list_event.dart';
part 'stocks_list_state.dart';

class StocksListBloc extends Bloc<StocksListEvent, StocksListState> {
  final GetStocksUseCase getStocksUseCase;

  StocksListBloc({required this.getStocksUseCase}) : super(const StockListInitial()) {
    on<LoadStocksEvent>(_onLoadStocks);
  }

  Future<void> _onLoadStocks(
    LoadStocksEvent event,
    Emitter<StocksListState> emit,
  ) async {
    emit(const StockListLoading());

    final result = await getStocksUseCase(NoParams());

    result.fold(
      (failure) => emit(StockListError(errorMessage: 'Failed to load stocks')),
      (stocks) => emit(StockListLoaded(stocks: stocks)),
    );
  }
}
