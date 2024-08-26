part of 'auth_bloc.dart';



abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignInSuccess extends AuthState {
  final String token;
  // final String role;

  const AuthSignInSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}



class AuthUnauthenticated extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// auth_state.dart
// abstract class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object?> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthAuthenticated extends AuthState {
//   final String token;
//   final String role;

//   const AuthAuthenticated({required this.token, required this.role});

//   @override
//   List<Object?> get props => [token, role];
// }

// class AuthUnauthenticated extends AuthState {}

// class AuthLogoutSuccess extends AuthState {}

// class AuthFailure extends AuthState {
//   final String error;

//   const AuthFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }
