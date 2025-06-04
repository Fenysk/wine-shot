import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../repositories/auth_repository.dart';

class IsAuthenticatedUseCase {
  final AuthRepository _repository;

  IsAuthenticatedUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.isAuthenticated();
  }
}
