import 'package:equatable/equatable.dart';
import '../../../domain/entities/country_entity.dart';

abstract class CountryListState extends Equatable {
  const CountryListState();

  @override
  List<Object?> get props => [];
}

class CountryListInitial extends CountryListState {}

class CountryListLoading extends CountryListState {}

class CountryListLoaded extends CountryListState {
  final List<CountryEntity> countries;

  const CountryListLoaded(this.countries);

  @override
  List<Object?> get props => [
        countries
      ];
}

class CountryLoaded extends CountryListState {
  final CountryEntity country;

  const CountryLoaded(this.country);

  @override
  List<Object?> get props => [
        country
      ];
}

class CountryListError extends CountryListState {
  final String message;

  const CountryListError(this.message);

  @override
  List<Object?> get props => [
        message
      ];
}
