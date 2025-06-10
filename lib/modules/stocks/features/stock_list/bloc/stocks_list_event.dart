part of 'stocks_list_bloc.dart';

abstract class StocksListEvent extends Equatable {
  const StocksListEvent();

  @override
  List<Object> get props => [];
}

class LoadStocksEvent extends StocksListEvent {
  const LoadStocksEvent();
}

class DeleteStockEvent extends StocksListEvent {
  final String stockId;

  const DeleteStockEvent({required this.stockId});

  @override
  List<Object> get props => [
        stockId
      ];
}
