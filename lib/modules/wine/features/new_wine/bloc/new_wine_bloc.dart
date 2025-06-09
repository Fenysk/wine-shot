import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../domain/usecases/create_wine_usecase.dart';
import '../../../data/dto/new_wine_dto.dart';

part 'new_wine_event.dart';
part 'new_wine_state.dart';

class NewWineBloc extends Bloc<NewWineEvent, NewWineState> {
  final CreateWineUseCase _createWineUsecase;

  NewWineBloc({required CreateWineUseCase createWineUsecase})
      : _createWineUsecase = createWineUsecase,
        super(NewWineState.initial()) {
    on<CreateWineEvent>(_onCreateWine);
  }

  Future<void> _onCreateWine(
    CreateWineEvent event,
    Emitter<NewWineState> emit,
  ) async {
    emit(NewWineState.loading());

    final result = await _createWineUsecase(event.wineDto);

    result.fold(
      (failure) => emit(NewWineState.failure(failure is ServerFailure ? 'Erreur lors de l\'ajout du vin' : 'Une erreur inattendue est survenue')),
      (_) => emit(NewWineState.success()),
    );
  }
}
