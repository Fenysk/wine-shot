import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../_core/usecases/usecase.dart';
import '../../../domain/usecases/get_countries.dart';
import 'country_list_event.dart';
import 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final GetCountries getCountries;

  CountryListBloc({
    required this.getCountries,
  }) : super(CountryListInitial()) {
    on<LoadCountries>(_onLoadCountries);
  }

  Future<void> _onLoadCountries(
    LoadCountries event,
    Emitter<CountryListState> emit,
  ) async {
    emit(CountryListLoading());
    final result = await getCountries(NoParams());
    result.fold(
      (failure) => emit(CountryListError(failure.toString())),
      (countries) => emit(CountryListLoaded(countries)),
    );
  }
}
