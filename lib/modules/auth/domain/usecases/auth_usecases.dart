import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import '../repositories/auth_repository.dart';
import '../user.dart';

class AuthUsecases {
  final AuthRepository _authRepository;

  AuthUsecases(this._authRepository);

  void dispose() => _authRepository.dispose();

  Future<Either<Failure, void>> isAuthenticated() {
    return _authRepository.isAuthenticated();
  }

  Stream<User> getUserStream() {
    return _authRepository.getCurrentUserStream();
  }

  Future<Either<Failure, void>> logout() {
    return _authRepository.logout();
  }

  Future<Either<Failure, void>> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phone,
  ) {
    return _authRepository.updateProfile(firstName, lastName, email, phone);
  }
}
