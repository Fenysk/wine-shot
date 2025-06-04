import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    return await _repository.updateProfile(firstName, lastName, email, phone);
  }
}
