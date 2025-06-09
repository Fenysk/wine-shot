import 'package:equatable/equatable.dart';
import '../../../../domain/entities/wine_entity.dart';

abstract class WineListState extends Equatable {
  const WineListState();

  @override
  List<Object?> get props => [];
}

class WineListInitial extends WineListState {
  const WineListInitial();
}

class WineListLoading extends WineListState {
  const WineListLoading();
}

class WineListLoaded extends WineListState {
  final List<WineEntity> wines;

  const WineListLoaded(this.wines);

  @override
  List<Object?> get props => [
        wines
      ];
}

class WineListError extends WineListState {
  final String message;

  const WineListError(this.message);

  @override
  List<Object?> get props => [
        message
      ];
}
