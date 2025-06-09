import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../_core/usecases/usecase.dart';
import '../../../domain/usecases/get_wines_usecase.dart';
import 'wine_list_event.dart';
import 'wine_list_state.dart';

class WineListBloc extends Bloc<WineListEvent, WineListState> {
  final GetWinesUseCase getWinesUseCase;

  WineListBloc({required this.getWinesUseCase}) : super(const WineListInitial()) {
    on<LoadWinesEvent>(_onLoadWines);
  }

  Future<void> _onLoadWines(
    LoadWinesEvent event,
    Emitter<WineListState> emit,
  ) async {
    emit(const WineListLoading());

    final result = await getWinesUseCase(NoParams());

    result.fold(
      (failure) => emit(WineListError(failure.toString())),
      (wines) => emit(WineListLoaded(wines)),
    );
  }
}
