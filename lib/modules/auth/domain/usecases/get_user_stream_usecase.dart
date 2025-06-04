import 'package:clean_starter/modules/auth/domain/entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserStreamUseCase {
  final AuthRepository _repository;

  GetUserStreamUseCase(this._repository);

  Stream<UserEntity> call() {
    return _repository.getCurrentUserStream();
  }
}
