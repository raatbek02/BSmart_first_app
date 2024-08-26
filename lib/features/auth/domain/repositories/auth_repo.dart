


import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/features/auth/domain/entities/sign_in_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<Either<Failure, Response>> signIn(SignInEntity signInEntity);
}
