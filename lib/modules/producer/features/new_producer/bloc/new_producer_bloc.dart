import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../_core/error/failures.dart';
import '../../../domain/entities/producer_entity.dart';
import '../../../domain/usecases/add_producer_usecase.dart';

part 'new_producer_event.dart';
part 'new_producer_state.dart';

class NewProducerBloc extends Bloc<NewProducerEvent, NewProducerState> {
  final AddProducerUsecase _addProducerUsecase;

  NewProducerBloc({required AddProducerUsecase addProducerUsecase})
      : _addProducerUsecase = addProducerUsecase,
        super(NewProducerState.initial()) {
    on<AddProducerEvent>(_onAddProducer);
  }

  Future<void> _onAddProducer(
    AddProducerEvent event,
    Emitter<NewProducerState> emit,
  ) async {
    emit(NewProducerState.loading());

    final result = await _addProducerUsecase(event.producer);

    result.fold(
      (failure) => emit(NewProducerState.failure(
        failure is ServerFailure ? 'Erreur lors de l\'ajout du producteur' : 'Une erreur inattendue est survenue',
      )),
      (_) => emit(NewProducerState.success()),
    );
  }
}
