


import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:bsmart_first_app/features/auth/domain/entities/sign_in_entity.dart';
import 'package:bsmart_first_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';



class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatabase remoteDatabase;

  AuthRepositoryImpl({
    required this.remoteDatabase,
  });

  @override
  Future<Either<Failure, Response>> signIn(SignInEntity signInEntity) async {
    try {
      final results = await remoteDatabase.signIn(signInEntity);
      return Right(results);
    } catch (e) {
      return Left(Failure("Error in login: $endoMi()"));
    }
  }

  }
