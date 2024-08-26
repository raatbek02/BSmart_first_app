import 'dart:convert';

class SignInEntity {
  final String email;
  final String password;

  SignInEntity({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "password": password,
    };
  }

  factory SignInEntity.fromMap(Map<String, dynamic> map) {
    return SignInEntity(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInEntity.fromJson(String source) =>
      SignInEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
