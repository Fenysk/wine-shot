part of 'stocks_list_bloc.dart';

abstract class StocksListState extends Equatable {
  const StocksListState();

  @override
  List<Object> get props => [];
}

class StockListInitial extends StocksListState {
  const StockListInitial();
}

class StockListLoading extends StocksListState {
  const StockListLoading();
}

class StockListError extends StocksListState {
  final String errorMessage;

  const StockListError({required this.errorMessage});

  @override
  List<Object> get props => [
        errorMessage
      ];
}

class StockListLoaded extends StocksListState {
  final List<WineStockEntity> stocks;

  const StockListLoaded({required this.stocks});

  @override
  List<Object> get props => [
        stocks
      ];
}
