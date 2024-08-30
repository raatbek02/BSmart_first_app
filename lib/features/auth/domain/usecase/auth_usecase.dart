import 'package:bsmart_first_app/core/api/%C2%A0api_constants.dart';
import 'package:bsmart_first_app/core/api/api_client.dart';
import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/core/utils/app_constants.dart';
import 'package:bsmart_first_app/features/auth/domain/entities/sign_in_entity.dart';
import 'package:bsmart_first_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/usecases.dart';




import 'package:jwt_decoder/jwt_decoder.dart';

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

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      await sharedPreferences.setString(
          ApiConstants.USER_ID, decodedToken['userId'] ?? '');
      await sharedPreferences.setString(
          ApiConstants.ROLE, decodedToken['role'] ?? '');
      await sharedPreferences.setString(
          ApiConstants.ORGANIZATION_ID, decodedToken['organizationId'] ?? '');
      await sharedPreferences.setString(
          ApiConstants.USER_NAME, decodedToken['name'] ?? '');

      return true;
    } catch (e) {
      logger.e("Error decoding or saving token data: $e");
      return false;
    }
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? '';
  }

  Future<Map<String, String>> getUserData() async {
    return {
      'userId': sharedPreferences.getString(ApiConstants.USER_ID) ?? '',
      'role': sharedPreferences.getString(ApiConstants.ROLE) ?? '',
      'organizationId':
          sharedPreferences.getString(ApiConstants.ORGANIZATION_ID) ?? '',
      'name': sharedPreferences.getString(ApiConstants.USER_NAME) ?? '',
    };
  }

  bool clearSharedData() {
    sharedPreferences.remove(ApiConstants.TOKEN);
    sharedPreferences.remove(ApiConstants.USER_ID);
    sharedPreferences.remove(ApiConstants.ROLE);
    sharedPreferences.remove(ApiConstants.ORGANIZATION_ID);
    sharedPreferences.remove(ApiConstants.USER_NAME);
    return true;
  }
}

class SignInParams extends Params<SignInEntity> {
  SignInParams(super.signInEntity);
}



// class AuthUseCase implements UseCase<Response, Params> {
//   final ApiClient apiClient;
//   final AuthRepository repository;
//   final SharedPreferences sharedPreferences;

//   AuthUseCase({
//     required this.apiClient,
//     required this.repository,
//     required this.sharedPreferences,
//   });

//   @override
//   Future<Either<Failure, Response>> call(Params params) async {
//     if (params is SignInParams) {
//       return await signIn(params.data);
//     } else {
//       return Left(Failure('Invalid parameters'));
//     }
//   }

//   Future<Either<Failure, Response>> signIn(SignInEntity entity) async {
//     return await repository.signIn(entity);
//   }

//   bool userLoggedIn() {
//     return sharedPreferences.containsKey(AppConstants.TOKEN);
//   }

//   Future<bool> saveUserToken(String token) async {
//     await sharedPreferences.setString(AppConstants.TOKEN, token);
//     // Обновление токена в ApiClient больше не требуется, так как это делается автоматически через AuthInterceptor
//     return true;
//   }

//   Future<String> getUserToken() async {
//     return sharedPreferences.getString(AppConstants.TOKEN) ?? '';
//   }



//   bool clearSharedData() {
//     sharedPreferences.remove(AppConstants.TOKEN);
//     // Обновление токена в ApiClient больше не требуется
//     return true;
//   }
// }

// class SignInParams extends Params<SignInEntity> {
//   SignInParams(super.signInEntity);
// }



  // Этот метод больше не нужен, так как заголовки обновляются автоматически
  // void updateHeader() {
  //   apiClient.updateHeader();
  // }