part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState {
  const InventoryLoading();
}

class InventoryError extends InventoryState {
  final String errorMessage;

  const InventoryError({required this.errorMessage});

  @override
  List<Object> get props => [
        errorMessage
      ];
}

class InventoryLoaded extends InventoryState {
  final List<WineStockEntity> stocks;

  const InventoryLoaded({required this.stocks});

  @override
  List<Object> get props => [
        stocks
      ];
}
