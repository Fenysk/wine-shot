import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Either<Failure, UserEntity?>> call() async {
    return await _repository.getCurrentUser();
  }
}
