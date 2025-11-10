import 'dart:developer';
import 'dart:io';

import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';

import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/restClient/rest_client.dart';
import 'package:barbershop/src/model/user_model.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  RestClient restClient;
  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorized());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar dados do usuário'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter dados do usuário', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: e.message));
    }
  }
}
