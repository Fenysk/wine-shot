import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecases/usecase.dart';
import '../entities/country_entity.dart';
import '../repositories/country_repository.dart';

class GetCountries extends UseCase<List<CountryEntity>, NoParams> {
  final CountryRepository repository;

  GetCountries(this.repository);

  @override
  Future<Either<Failure, List<CountryEntity>>> call(NoParams params) async {
    return await repository.getCountries();
  }
}
