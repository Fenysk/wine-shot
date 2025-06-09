import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../_core/usecases/usecase.dart';
import '../../../../domain/entities/wine_type_entity.dart';
import '../../../../domain/usecases/get_wine_types_usecase.dart';

part 'wine_types_list_event.dart';
part 'wine_types_list_state.dart';

class WineTypesListBloc extends Bloc<WineTypesListEvent, WineTypesListState> {
  final GetWineTypesUseCase getWineTypesUseCase;

  WineTypesListBloc({required this.getWineTypesUseCase}) : super(WineTypesListInitial()) {
    on<LoadWineTypesEvent>(_onLoadWineTypes);
  }

  Future<void> _onLoadWineTypes(
    LoadWineTypesEvent event,
    Emitter<WineTypesListState> emit,
  ) async {
    emit(WineTypesListLoading());

    final result = await getWineTypesUseCase(NoParams());

    result.fold(
      (failure) => emit(WineTypesListError(message: failure.toString())),
      (wineTypes) => emit(WineTypesListLoaded(wineTypes: wineTypes)),
    );
  }
}
