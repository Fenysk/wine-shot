import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_shared/domain/entities/region_entity.dart';
import '../../../data/models/new_region_dto.dart';
import '../../../domain/usecases/add_region_usecase.dart';
import '../../../domain/usecases/get_regions_usecase.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final GetRegionsUsecase getRegionsUsecase;
  final AddRegionUseCase addRegionUseCase;

  RegionBloc({
    required this.getRegionsUsecase,
    required this.addRegionUseCase,
  }) : super(RegionInitial()) {
    on<LoadRegionsEvent>(_onLoadRegions);
    on<CreateNewRegionEvent>(_onCreateNewRegion);
  }

  Future<void> _onLoadRegions(
    LoadRegionsEvent event,
    Emitter<RegionState> emit,
  ) async {
    emit(RegionLoading());
    final result = await getRegionsUsecase();
    result.fold(
      (failure) => emit(RegionError('Erreur lors du chargement des régions')),
      (regions) => emit(RegionLoaded(regions)),
    );
  }

  Future<void> _onCreateNewRegion(
    CreateNewRegionEvent event,
    Emitter<RegionState> emit,
  ) async {
    emit(RegionLoading());
    final result = await addRegionUseCase(event.dto);
    result.fold(
      (failure) => emit(RegionError('Erreur lors de la création de la région')),
      (region) => add(LoadRegionsEvent()),
    );
  }
}
