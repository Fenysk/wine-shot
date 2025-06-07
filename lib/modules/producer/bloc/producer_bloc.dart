import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/producer_entity.dart';
import '../domain/usecases/get_producers_usecase.dart';

part 'producer_event.dart';
part 'producer_state.dart';

class ProducerBloc extends Bloc<ProducerEvent, ProducerState> {
  final GetProducersUsecase getProducersUsecase;

  ProducerBloc({required this.getProducersUsecase}) : super(ProducerInitial()) {
    on<LoadProducersEvent>(_onLoadProducers);
  }

  Future<void> _onLoadProducers(
    LoadProducersEvent event,
    Emitter<ProducerState> emit,
  ) async {
    emit(ProducerLoading());
    final result = await getProducersUsecase();

    result.fold(
      (failure) => emit(ProducerError(errorMessage: 'Failed to load producers')),
      (producers) => emit(ProducerLoaded(producers: producers)),
    );
  }
}
