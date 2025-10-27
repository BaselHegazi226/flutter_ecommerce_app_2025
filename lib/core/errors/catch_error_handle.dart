import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';

class CatchErrorHandle {
  static dynamic catchBack({required Object failure}) {
    if (failure is FirebaseAuthException) {
      debugPrint('firebase auth exception = ${failure.message}');
      return FirebaseFailure.fromFirebaseAuthException(exception: failure);
    } else if (failure is FirebaseException) {
      debugPrint('firebase exception = $failure');
      return FirebaseFailure.fromFirebaseException(exception: failure);
    } else {
      debugPrint('exception = ${failure.toString()}');
      return ServerFailure(errorMessage: failure.toString());
    }
  }
}
