part of 'wine_types_list_bloc.dart';

sealed class WineTypesListEvent extends Equatable {
  const WineTypesListEvent();

  @override
  List<Object> get props => [];
}

class LoadWineTypesEvent extends WineTypesListEvent {}
