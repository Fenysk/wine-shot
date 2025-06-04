import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity> getCurrentUserStream();
  void dispose();

  Future<Either<Failure, void>> isAuthenticated();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> login({required String email, required String password});
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  void updateCachedUser(UserEntity user);

  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  });

  Future<Either<Failure, void>> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phone,
  );
}
