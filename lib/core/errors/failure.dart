import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String? errorKey;

  const Failure({required this.errorKey});
}

// Server errors
class ServerFailure extends Failure {
  const ServerFailure({required super.errorKey});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(errorKey: 'connectionTimeout');

      case DioExceptionType.sendTimeout:
        return const ServerFailure(errorKey: 'sendTimeout');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure(errorKey: 'receiveTimeout');

      case DioExceptionType.connectionError:
        return const ServerFailure(errorKey: 'connectionError');

      case DioExceptionType.unknown:
        return const ServerFailure(errorKey: 'unexpectedError');

      default:
        return const ServerFailure(errorKey: 'unknownServerError');
    }
  }

  factory ServerFailure.fromResponse({
    required int? statusCode,
    required dynamic responseData,
  }) {
    switch (statusCode) {
      case 400:
        return const ServerFailure(errorKey: 'badRequest');
      case 401:
        return const ServerFailure(errorKey: 'unauthorized');
      case 403:
        return const ServerFailure(errorKey: 'forbidden');
      case 404:
        return const ServerFailure(errorKey: 'notFound');
      case 409:
        return const ServerFailure(errorKey: 'conflict');
      case 500:
        return const ServerFailure(errorKey: 'internalServerError');
      default:
        return const ServerFailure(errorKey: 'unknownServerError');
    }
  }
}

//firebase errors
class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.errorKey});

  factory FirebaseFailure.fromFirebaseException({
    required FirebaseException exception,
  }) {
    switch (exception.code) {
      case 'network-request-failed':
        return const FirebaseFailure(errorKey: 'networkRequestFailed');

      case 'too-many-requests':
        return const FirebaseFailure(errorKey: 'tooManyRequests');

      case 'user-not-found':
        return const FirebaseFailure(errorKey: 'userNotFound');

      case 'wrong-password':
        return const FirebaseFailure(errorKey: 'wrongPassword');

      case 'email-already-in-use':
        return const FirebaseFailure(errorKey: 'emailAlreadyInUse');

      case 'invalid-email':
        return const FirebaseFailure(errorKey: 'invalidEmail');

      case 'weak-password':
        return const FirebaseFailure(errorKey: 'weakPassword');

      case 'operation-not-allowed':
        return const FirebaseFailure(errorKey: 'operationNotAllowed');

      case 'user-disabled':
        return const FirebaseFailure(errorKey: 'userDisabled');

      case 'requires-recent-login':
        return const FirebaseFailure(errorKey: 'requiresRecentLogin');

      case 'invalid-verification-code':
        return const FirebaseFailure(errorKey: 'invalidVerificationCode');

      case 'invalid-verification-id':
        return const FirebaseFailure(errorKey: 'invalidVerificationId');

      default:
        return const FirebaseFailure(errorKey: 'unknownFirebaseError');
    }
  }
}
