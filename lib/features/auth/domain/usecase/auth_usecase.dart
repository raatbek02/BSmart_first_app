import 'package:bsmart_first_app/core/api/api_client.dart';
import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/utils/app_constants.dart';
import 'package:bsmart_first_app/features/auth/domain/entities/sign_in_entity.dart';
import 'package:bsmart_first_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/usecases.dart';

class AuthUseCase implements UseCase<Response, Params> {
  final ApiClient apiClient;
  final AuthRepository repository;
  final SharedPreferences sharedPreferences;

  AuthUseCase({
    required this.apiClient,
    required this.repository,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, Response>> call(Params params) async {
    if (params is SignInParams) {
      return await signIn(params.data);
    } else {
      return Left(Failure('Invalid parameters'));
    }
  }

  Future<Either<Failure, Response>> signIn(SignInEntity entity) async {
    return await repository.signIn(entity);
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> saveUserToken(String token) async {
    await sharedPreferences.setString(AppConstants.TOKEN, token);
    // Обновление токена в ApiClient больше не требуется, так как это делается автоматически через AuthInterceptor
    return true;
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? '';
  }

  // Этот метод больше не нужен, так как заголовки обновляются автоматически
  // void updateHeader() {
  //   apiClient.updateHeader();
  // }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    // Обновление токена в ApiClient больше не требуется
    return true;
  }
}

class SignInParams extends Params<SignInEntity> {
  SignInParams(super.signInEntity);
}
