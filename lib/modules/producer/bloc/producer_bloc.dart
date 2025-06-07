import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/producer_entity.dart';
import '../domain/usecases/get_producers_usecase.dart';
import '../domain/usecases/delete_producer_usecase.dart';

part 'producer_event.dart';
part 'producer_state.dart';

class ProducerBloc extends Bloc<ProducerEvent, ProducerState> {
  final GetProducersUsecase getProducersUsecase;
  final DeleteProducerUsecase deleteProducerUsecase;

  ProducerBloc({
    required this.getProducersUsecase,
    required this.deleteProducerUsecase,
  }) : super(ProducerInitial()) {
    on<LoadProducersEvent>(_onLoadProducers);
    on<DeleteProducerEvent>(_onDeleteProducer);
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

  Future<void> _onDeleteProducer(
    DeleteProducerEvent event,
    Emitter<ProducerState> emit,
  ) async {
    final result = await deleteProducerUsecase(event.producerId);

    result.fold(
      (failure) => emit(ProducerError(errorMessage: 'Failed to delete producer')),
      (_) => add(LoadProducersEvent()),
    );
  }
}
