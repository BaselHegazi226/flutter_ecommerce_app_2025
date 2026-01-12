import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserCredential>> signInWithGoogle();
  Future<Either<Failure, UserCredential?>> signInWithFacebook();
  Future<Either<Failure, UserCredential>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserCredential>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String?>> isNewUser();
  Future<Either<Failure, bool>> forgetPassword();
  Future<Either<Failure, bool>> updatePassword();
  Future<Either<Failure, bool>> verifyEmail();
  Future<Either<Failure, bool>> verifyCode();
}
