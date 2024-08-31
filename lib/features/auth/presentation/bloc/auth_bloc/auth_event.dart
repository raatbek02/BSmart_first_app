part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LoadUserDataEvent extends AuthEvent {}





class LogoutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}




// auth_event.dart

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object?> get props => [];
// }

// class SignInEvent extends AuthEvent {
//   final String phoneNumber;
//   final String password;

//   const SignInEvent(this.phoneNumber, this.password);

//   @override
//   List<Object?> get props => [phoneNumber, password];
// }

// class SignUpEvent extends AuthEvent {
//   final String firstName;
//   final String phoneNumber;
//   final String password;

//   const SignUpEvent(this.firstName, this.phoneNumber, this.password);

//   @override
//   List<Object?> get props => [firstName, phoneNumber, password];
// }

// class DeleteUserEvent extends AuthEvent {}

// class LogoutEvent extends AuthEvent {}


// class CheckAuthStatusEvent extends AuthEvent {}