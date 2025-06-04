import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_user_stream_usecase.dart';
import '../domain/usecases/is_authenticated_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/entities/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final GetUserStreamUseCase _getUserStreamUseCase;
  final IsAuthenticatedUseCase _isAuthenticatedUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({
    required AuthRepository authRepository,
    required GetUserStreamUseCase getUserStreamUseCase,
    required IsAuthenticatedUseCase isAuthenticatedUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _authRepository = authRepository,
        _getUserStreamUseCase = getUserStreamUseCase,
        _isAuthenticatedUseCase = isAuthenticatedUseCase,
        _logoutUseCase = logoutUseCase,
        super(const AuthState()) {
    on<AppLoaded>(_appLoaded);
    on<AuthStatusSubscriptionRequested>(_onAuthSubscriptionRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  @override
  Future<void> close() {
    _authRepository.dispose();
    return super.close();
  }

  Future<void> _appLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    await _isAuthenticatedUseCase();
  }

  Future<void> _onAuthSubscriptionRequested(
    AuthStatusSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _isAuthenticatedUseCase();
    await emit.forEach<UserEntity>(
      _getUserStreamUseCase(),
      onData: (user) {
        // print("auth_bloc: $user");
        if (user == UserEntity.empty) {
          return state.copyWith(
            status: AuthStatus.unauthenticated,
            user: user,
          );
        } else {
          // if (!user.isEmailVerified) {
          //   return state.copyWith(
          //     status: AuthStatus.unverified,
          //     user: user,
          //   );
          // }

          return state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
          );
        }
      },
      onError: (_, __) {
        return state.copyWith(
          status: AuthStatus.unauthenticated,
        );
      },
    );
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _logoutUseCase();
  }
}
