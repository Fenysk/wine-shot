import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/producer_entity.dart';
import '../../../domain/usecases/add_producer_usecase.dart';

part 'new_producer_event.dart';
part 'new_producer_state.dart';

class NewProducerBloc extends Bloc<NewProducerEvent, NewProducerState> {
  final AddProducerUsecase addProducerUsecase;

  NewProducerBloc({required this.addProducerUsecase}) : super(NewProducerInitial()) {
    on<AddProducerEvent>(_onAddProducer);
  }

  Future<void> _onAddProducer(
    AddProducerEvent event,
    Emitter<NewProducerState> emit,
  ) async {
    emit(NewProducerLoading());
    final result = await addProducerUsecase(event.producer);

    result.fold(
      (failure) => emit(NewProducerFailure(message: 'Failed to create new producer')),
      (producer) => emit(NewProducerSuccess(producer: producer)),
    );
  }
}
