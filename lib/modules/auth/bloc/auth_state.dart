part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  unverified
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity user;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user = UserEntity.empty,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [
        status,
        user
      ];
}
