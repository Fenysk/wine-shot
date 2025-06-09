import 'package:equatable/equatable.dart';

abstract class WineListEvent extends Equatable {
  const WineListEvent();

  @override
  List<Object?> get props => [];
}

class LoadWinesEvent extends WineListEvent {
  const LoadWinesEvent();
}
