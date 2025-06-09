part of 'wine_types_list_bloc.dart';

sealed class WineTypesListState extends Equatable {
  const WineTypesListState();

  @override
  List<Object> get props => [];
}

final class WineTypesListInitial extends WineTypesListState {}

final class WineTypesListLoading extends WineTypesListState {}

final class WineTypesListLoaded extends WineTypesListState {
  final List<WineTypeEntity> wineTypes;

  const WineTypesListLoaded({required this.wineTypes});
}

final class WineTypesListError extends WineTypesListState {
  final String message;

  const WineTypesListError({required this.message});
}
