import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/repositories/country_repository.dart';
import '../sources/country_remote_source.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteSource remoteSource;

  CountryRepositoryImpl({
    required this.remoteSource,
  });

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    try {
      final countries = await remoteSource.getCountries();
      return Right(countries);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
