import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class UpdateCachedUserUseCase {
  final AuthRepository _repository;

  UpdateCachedUserUseCase(this._repository);

  void call(UserEntity user) {
    _repository.updateCachedUser(user);
  }
}
