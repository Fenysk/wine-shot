import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthApiException;

import '../../../_core/constants.dart';
import '../../../_core/di.dart';
import '../../../_core/error/exceptions.dart';
import '../../../_core/error/failures.dart';
import '../../../_core/network_info.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';
import 'models/user_model.dart';
import 'services/auth_supabase_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _userController = BehaviorSubject<User>();

  final Dio dio;
  final HiveInterface hive;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.dio,
    required this.hive,
    required this.networkInfo,
  });

  @override
  Stream<User> getUserStream() => _userController.asBroadcastStream();

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await clearCache();
      _userController.add(User.empty);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure("Oops, Something went wrong while clearing cached data!"));
    }
  }

  @override
  void dispose() => _userController.close();

  @override
  Future<Either<Failure, void>> isAuthenticated() async {
    try {
      if (_userController.hasValue) {
        return Right(null);
      } else {
        final user = await _getCachedUser();
        _userController.add(user);
      }
      return Right(null);
    } catch (error) {
      _userController.add(User.empty);
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
      UserModel user = UserModel(
        authResponse.user!.id,
        authResponse.user!.userMetadata?['first_name'] ?? '',
        authResponse.user!.userMetadata?['last_name'] ?? '',
        authResponse.user!.phone ?? '',
        authResponse.user!.email ?? '',
        authResponse.user!.emailConfirmedAt != null,
        [
          if (authResponse.user!.role != null) authResponse.user!.role!
        ],
      );
      await _cacheUser(user);

      _userController.add(user);

      return Right(null);
    } catch (error) {
      switch (error) {
        case AuthApiException e: // Supabase Exception
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
        case AuthApiException e: // Supabase Exception
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
  Future<Either<Failure, User?>> getUser() async {
    try {
      var user = await _getUser();
      _userController.add(user);
      return Right(user);
    } catch (error) {
      if (error is DioException) {
        final message = DioExceptions.fromDioError(error).toString();
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure());
    }
  }

  Future<UserModel> _getUser() async {
    String path = '/users/me';
    final response = await dio.get(path);
    var user = UserModel.fromJson(response.data['data']);
    return user;
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
