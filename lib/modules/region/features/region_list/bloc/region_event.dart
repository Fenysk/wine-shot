part of 'region_bloc.dart';

sealed class RegionEvent extends Equatable {
  const RegionEvent();

  @override
  List<Object?> get props => [];
}

class LoadRegionsEvent extends RegionEvent {}

class CreateNewRegionEvent extends RegionEvent {
  final NewRegionDto dto;

  const CreateNewRegionEvent(this.dto);

  @override
  List<Object?> get props => [
        dto
      ];
}
