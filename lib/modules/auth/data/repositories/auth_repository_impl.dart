import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

import '../../../../_core/constants.dart';
import '../../../../_core/di.dart';
import '../../../../_core/error/exceptions.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/user.dart';
import '../models/user_model.dart';
import '../services/auth_supabase_service.dart';
import '../services/profile_supabase_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _currentUserController = BehaviorSubject<User>();

  final Dio dio;
  final HiveInterface hive;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.dio,
    required this.hive,
    required this.networkInfo,
  });

  @override
  Stream<User> getCurrentUserStream() => _currentUserController.asBroadcastStream();

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await clearCache();
      _currentUserController.add(User.empty);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure("Oops, Something went wrong while clearing cached data!"));
    }
  }

  @override
  void dispose() => _currentUserController.close();

  @override
  Future<Either<Failure, void>> isAuthenticated() async {
    try {
      if (_currentUserController.hasValue) {
        return Right(null);
      } else {
        final user = await _getCachedUser();
        _currentUserController.add(user);
      }
      return Right(null);
    } catch (error) {
      _currentUserController.add(User.empty);
      return Left(CacheFailure('Error occurred while loading cached data!'));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      // String path = '/users/login';
      // final tokenRes = await dio.post(path, data: {
      //   "email": email,
      //   "password": password
      // });
      final authResponse = await di<AuthSupabaseService>().signInWithEmailAndPassword(email, password);
      if (authResponse == null || authResponse.user == null || authResponse.session == null) {
        return Left(ServerFailure('Invalid email or password'));
      }

      // String? token = tokenRes.data?['data']['token'];
      String token = authResponse.session!.accessToken;
      await _cacheToken(token);

      // final user = await _getUser();
      // await _cacheUser(user);
      UserModel user = _userModelFromSupabaseUser(authResponse.user!);
      await _cacheUser(user);

      _currentUserController.add(user);

      return Right(null);
    } catch (error) {
      switch (error) {
        case supabase_flutter.AuthApiException e: // Supabase Exception
          print("Supabase Exception: ${e.toString()}");
          return Left(ServerFailure(e.toString()));

        case DioException e:
          final message = DioExceptions.fromDioError(e).toString();
          print("DioException: $message");
          return Left(ServerFailure(message));

        default:
          print("Unknown error during registration: ${error.toString()}");
          return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  }) async {
    try {
      // String path = '/users';
      // await dio.post(path, data: {
      //   'firstName': firstName,
      //   'lastName': lastName,
      //   'phone': phone,
      //   'email': email,
      //   'password': password,
      //   'isTermAndConditionAgreed': iAgree,
      // });
      final authResponse = await di<AuthSupabaseService>().signUpWithEmailAndPassword(email, password);
      if (authResponse == null || authResponse.user == null) {
        return Left(ServerFailure('Registration failed.'));
      }

      // Neither the token nor the user is cached because there is no session provided by Supabase.
      // Once the user is created, they are redirected to the login page.

      return Right(null);
    } catch (error) {
      switch (error) {
        case supabase_flutter.AuthApiException e: // Supabase Exception
          print("Supabase Exception: ${e.toString()}");
          return Left(ServerFailure(e.toString()));

        case DioException e:
          final message = DioExceptions.fromDioError(e).toString();
          print("DioException: $message");
          return Left(ServerFailure(message));

        default:
          print("Unknown error during registration: ${error.toString()}");
          return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      var user = await _getUserModel();
      _currentUserController.add(user);
      return Right(user);
    } catch (error) {
      if (error is DioException) {
        final message = DioExceptions.fromDioError(error).toString();
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure());
    }
  }

  @override
  void updateCachedUser(User user) {
    final userModel = UserModel(user.id, user.firstName, user.lastName, user.phone, user.email, user.isEmailVerified, user.roles);

    _cacheUser(userModel);
  }

  @override
  Future<Either<Failure, void>> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    try {
      final editUserFirstNameResponse = await di<ProfileSupabaseService>().updateProfile(firstName, lastName, email, phone);

      UserModel user = _userModelFromSupabaseUser(editUserFirstNameResponse!);

      _currentUserController.add(user);

      await _cacheUser(user);

      return Right(null);
    } catch (errorMessage) {
      return Left(ServerFailure(errorMessage.toString()));
    }
  }

  Future<UserModel> _getUserModel() async {
    final user = await di<AuthSupabaseService>().getCurrentUser();

    if (user == null) {
      throw CacheException();
    }

    return _userModelFromSupabaseUser(user);
  }

  UserModel _userModelFromSupabaseUser(supabase_flutter.User user) {
    return UserModel(
      user.id,
      user.userMetadata?['first_name'] ?? '',
      user.userMetadata?['last_name'] ?? '',
      user.phone ?? '',
      user.email ?? '',
      user.emailConfirmedAt != null,
      [
        if (user.role != null) user.role!
      ],
    );
  }

  Future<void> _cacheToken(String token) async {
    try {
      final tokenBox = await hive.openLazyBox(Constants.tokenBoxName);
      await tokenBox.put(Constants.cachedTokenRef, token);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> _cacheUser(UserModel user) async {
    try {
      final userBox = await hive.openLazyBox(Constants.userBoxName);
      userBox.put(Constants.cachedUserRef, user);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<UserModel> _getCachedUser() async {
    final userBox = await hive.openLazyBox(Constants.userBoxName);
    final user = await userBox.get(Constants.cachedUserRef);
    if (user != null) {
      return user;
    } else {
      throw CacheException();
    }
  }

  Future<void> clearCache() async {
    final userBox = await hive.openLazyBox(Constants.userBoxName);
    final tokenBox = await hive.openLazyBox(Constants.tokenBoxName);
    await tokenBox.clear();
    await userBox.clear();
  }
}
