import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../entities/country_entity.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
}
