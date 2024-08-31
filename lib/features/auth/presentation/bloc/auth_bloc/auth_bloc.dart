import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/auth/domain/entities/sign_in_entity.dart';
import 'package:bsmart_first_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  // Приватные поля для хранения данных пользователя
  String _userId = '';
  String _userRole = '';
  String _organizationId = '';
  String _userName = '';
  String _token = '';

  AuthBloc({required this.authUseCase}) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoadUserDataEvent>(_onLoadUserData);
  }

  // Геттеры для доступа к данным пользователя
  String get userId => _userId;
  String get userRole => _userRole;
  String get organizationId => _organizationId;
  String get userName => _userName;
  String get token => _token;

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i("AuthLoading state emitted");

    final result = await authUseCase.call(SignInParams(SignInEntity(
      email: event.email.trim(),
      password: event.password.trim(),
    )));

    logger.i("Result received: $result");

    await result.fold(
      (failure) async {
        logger.e("Auth failure: ${failure.message}");
        emit(AuthFailure(failure.message));
      },
      (response) async {
        logger.i("Auth response: ${response.data}");
        logger.i("Auth status code: ${response.statusCode}");

        if (response.statusCode == 200) {
          _token = response.data["access_token"];
          final saveResult = await authUseCase.saveUserToken(_token);
          if (saveResult) {
            await _loadAndUpdateUserData();
            emit(AuthSignInSuccess(
              token: _token,
              userId: _userId,
              role: _userRole,
              organizationId: _organizationId,
              name: _userName,
            ));
          } else {
            emit(AuthFailure('Ошибка при сохранении данных пользователя'));
          }
        } else {
          String errorMessage =
              response.statusMessage ?? 'Произошла ошибка при входе';
          if (response.data != null && response.data['message'] != null) {
            errorMessage = response.data['message'];
          }
          logger.e("Error auth login: $errorMessage");
          emit(AuthFailure(errorMessage));
        }
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i("Logging out...");
    await _logout();
    _clearUserData();
    emit(AuthUnauthenticated());
    emit(AuthLogoutSuccess());
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    final isLoggedIn = authUseCase.userLoggedIn();
    if (isLoggedIn) {
      await _loadAndUpdateUserData();
      emit(AuthSignInSuccess(
        token: _token,
        userId: _userId,
        role: _userRole,
        organizationId: _organizationId,
        name: _userName,
      ));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoadUserData(
      LoadUserDataEvent event, Emitter<AuthState> emit) async {
    final isLoggedIn = authUseCase.userLoggedIn();
    if (isLoggedIn) {
      await _loadAndUpdateUserData();
      emit(AuthSignInSuccess(
        token: _token,
        userId: _userId,
        role: _userRole,
        organizationId: _organizationId,
        name: _userName,
      ));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _loadAndUpdateUserData() async {
    _token = await authUseCase.getUserToken();
    final userData = await authUseCase.getUserData();
    _updateUserData(userData);
  }

  void _updateUserData(Map<String, dynamic> userData) {
    _userId = userData['userId'] ?? '';
    _userRole = userData['role'] ?? '';
    _organizationId = userData['organizationId'] ?? '';
    _userName = userData['name'] ?? '';
  }

  void _clearUserData() {
    _userId = '';
    _userRole = '';
    _organizationId = '';
    _userName = '';
    _token = '';
  }

  bool userLoggedIn() {
    return authUseCase.userLoggedIn();
  }

  Future<void> _logout() async {
    await authUseCase.clearSharedData();
  }
}
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthUseCase authUseCase;

//   AuthBloc({
//     required this.authUseCase,
//   }) : super(AuthInitial()) {
//     on<SignInEvent>(_onSignIn);
//     on<LogoutEvent>(_onLogout);
//     on<CheckAuthStatusEvent>(_onCheckAuthStatus);
//   }

// Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     logger.i("AuthLoading state emitted");
//     final result = await authUseCase.call(SignInParams(SignInEntity(
//       email: event.email.trim(),
//       password: event.password.trim(),
//     )));
//     logger.i("Result received: $result");
//     await result.fold(
//       (failure) async {
//         logger.e("Auth failure: ${failure.message}");
//         emit(AuthFailure(failure.message));
//       },
//       (response) async {
//         logger.i("Auth response: ${response.data}");
//         logger.i("Auth status code: ${response.statusCode}");
//         if (response.statusCode == 200) {
//           // Успешный вход
//           await authUseCase.saveUserToken(response.data["access_token"]);
//           // await authUseCase.saveUserRole(response.data['role']);
//           emit(AuthSignInSuccess(token: response.data['access_token']));
//         } else {
//           // Обработка ошибки
//           String errorMessage =
//               response.statusMessage ?? 'Произошла ошибка при входе';
//           if (response.data != null && response.data['message'] != null) {
//             errorMessage = response.data['message'];
//           }
//           logger.e("Error auth login: $errorMessage");
//           emit(AuthFailure(errorMessage));
//         }
//       },
//     );
//   }


//   Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     logger.i("Logging out...");
//     await _logout();
//     emit(AuthUnauthenticated());
//     emit(AuthLogoutSuccess());
//   }

//   Future<void> _onCheckAuthStatus(
//       CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
//     final isLoggedIn = authUseCase.userLoggedIn();
//     if (isLoggedIn) {
//       final token = await authUseCase.getUserToken();
//       emit(AuthSignInSuccess(token: token));
//     } else {
//       emit(AuthUnauthenticated());
//     }
//   }

//   bool userLoggedIn() {
//     return authUseCase.userLoggedIn();
//   }


//   Future<void> _logout() async {
//     authUseCase.clearSharedData();
//   }
// }





// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthUseCase authUseCase;

//   AuthBloc({
//     required this.authUseCase,
//   }) : super(AuthInitial()) {
//     on<SignInEvent>(_onSignIn);
//     on<LogoutEvent>(_onLogout);
//     on<CheckAuthStatusEvent>(_onCheckAuthStatus);
//   }

//   Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
//     logger.i("SignInEvent received with email: ${event.email}");
//     emit(AuthLoading());
//     logger.i("AuthLoading state emitted");

//     final signInEntity = SignInEntity(
//       email: event.email.trim(),
//       password: event.password.trim(),
//     );
//     logger.i("SignInEntity created: ${signInEntity.toMap()}");

//     final result = await authUseCase.call(SignInParams(signInEntity));
//     logger.i("AuthUseCase result received");

//     await result.fold(
//       (failure) async {
//         logger.e("Auth failure: ${failure.message}");
//         emit(AuthFailure(failure.message));
//       },
//       (response) async {
//         logger.i("Auth response status code: ${response.statusCode}");
//         logger.i("Auth response data: ${response.data}");
//         logger.i("Auth response headers: ${response.headers}");

//         if (response.statusCode == 200) {
//           logger.i("Successful login");
//           final token = response.data["access_token"];
//           if (token != null) {
//             await authUseCase.saveUserToken(token);
//             logger.i("User token saved");
//             emit(AuthSignInSuccess(token: token));
//           } else {
//             logger.e("Access token is null in the response");
//             emit(AuthFailure("Invalid response from server"));
//           }
//         } else {
//           String errorMessage =
//               response.statusMessage ?? 'Произошла ошибка при входе';
//           if (response.data != null && response.data['message'] != null) {
//             errorMessage = response.data['message'];
//           }
//           logger.e("Login error: $errorMessage");
//           emit(AuthFailure(errorMessage));
//         }
//       },
//     );
//   }

//   Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
//     logger.i("LogoutEvent received");
//     emit(AuthLoading());
//     logger.i("AuthLoading state emitted");

//     try {
//       await _logout();
//       logger.i("Logout successful");
//       emit(AuthUnauthenticated());
//       emit(AuthLogoutSuccess());
//     } catch (e) {
//       logger.e("Error during logout: $e");
//       emit(AuthFailure("Ошибка при выходе из системы"));
//     }
//   }

//   Future<void> _onCheckAuthStatus(
//       CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
//     logger.i("CheckAuthStatusEvent received");
//     final isLoggedIn = authUseCase.userLoggedIn();
//     logger.i("User logged in status: $isLoggedIn");

//     if (isLoggedIn) {
//       final token = await authUseCase.getUserToken();
//       logger.i(
//           "User token retrieved: ${token.isNotEmpty ? 'Token present' : 'Token empty'}");
//       emit(AuthSignInSuccess(token: token));
//     } else {
//       logger.i("User is not logged in");
//       emit(AuthUnauthenticated());
//     }
//   }

//   bool userLoggedIn() {
//     final loggedIn = authUseCase.userLoggedIn();
//     logger.i("Checking if user is logged in: $loggedIn");
//     return loggedIn;
//   }

//   Future<void> _logout() async {
//     logger.i("Clearing shared data for logout");
//     await authUseCase.clearSharedData();
//     logger.i("Shared data cleared");
//   }
// }
