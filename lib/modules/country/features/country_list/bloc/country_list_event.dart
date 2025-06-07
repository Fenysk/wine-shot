import 'package:equatable/equatable.dart';

abstract class CountryListEvent extends Equatable {
  const CountryListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCountries extends CountryListEvent {}

class LoadCountryById extends CountryListEvent {
  final String id;

  const LoadCountryById(this.id);

  @override
  List<Object?> get props => [
        id
      ];
}
