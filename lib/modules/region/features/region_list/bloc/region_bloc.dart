import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_shared/domain/entities/region_entity.dart';
import '../../../domain/usecases/get_regions_usecase.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final GetRegionsUsecase getRegionsUsecase;
  RegionBloc({required this.getRegionsUsecase}) : super(RegionInitial()) {
    on<LoadRegionsEvent>(_onLoadRegions);
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
}
