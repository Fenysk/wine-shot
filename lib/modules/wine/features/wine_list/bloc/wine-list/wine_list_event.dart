import 'package:equatable/equatable.dart';

abstract class WineListEvent extends Equatable {
  const WineListEvent();

  @override
  List<Object?> get props => [];
}

class LoadWinesEvent extends WineListEvent {
  const LoadWinesEvent();
}

class DeleteWineEvent extends WineListEvent {
  final String wineId;

  const DeleteWineEvent({required this.wineId});

  @override
  List<Object?> get props => [
        wineId
      ];
}
