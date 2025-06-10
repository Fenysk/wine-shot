part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventoryEvent extends InventoryEvent {
  const LoadInventoryEvent();
}

class DeleteInventoryEvent extends InventoryEvent {
  final String itemStockId;

  const DeleteInventoryEvent({required this.itemStockId});

  @override
  List<Object> get props => [
        itemStockId
      ];
}
