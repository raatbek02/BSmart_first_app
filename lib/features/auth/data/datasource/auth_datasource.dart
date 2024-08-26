import 'package:bsmart_first_app/core/api/api_client.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/auth/domain/entities/sign_in_entity.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatabase {
  Future<Response> signIn(SignInEntity signInEntity);
}

class AuthRemoteDatabaseImpls implements AuthRemoteDatabase {
  final ApiClient apiClient;
  AuthRemoteDatabaseImpls({required this.apiClient});

  @override
  Future<Response> signIn(SignInEntity signInEntity) async {
    logger.i("Attempting to sign in with email: ${signInEntity.email}");
    logger.i("SignInEntity data: ${signInEntity.toMap()}");

    try {
      final response =
          await apiClient.postData('/api/users/auth', signInEntity.toMap());
      logger.i("Sign in response received: ${response.statusCode}");
      logger.i("Response data: ${response.data}");
      return response;
    } catch (e) {
      logger.e("Error during sign in: $e");
      rethrow;
    }
  }
}

// abstract class AuthRemoteDatabase {
//   Future<Response> signIn(SignInEntity signInEntity);
// }

// class AuthRemoteDatabaseImpls implements AuthRemoteDatabase {
//   final ApiClient apiClient;

//   AuthRemoteDatabaseImpls({required this.apiClient});

//   @override
//   Future<Response> signIn(SignInEntity signInEntity) async {
//     logger.i("Called SignIn method in AuthRemoteDatabaseImpls");
//     return await apiClient.postData(
//         '/api/users/auth',
//         // signInEntity.toMap(),
//         {'email': "999@gmail.com", 'password': "123123"});
//     // return signInEntity;
//   }
// }
