import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  }) async {
    return await _repository.register(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
      iAgree: iAgree,
    );
  }
}
