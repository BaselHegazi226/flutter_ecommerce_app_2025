import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String? errorMessage;

  const Failure({required this.errorMessage});
}

// Server errors
class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          errorMessage: 'Connection timeout. Please try again.',
        );
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          errorMessage: 'Send timeout. Please try again.',
        );
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          errorMessage: 'Receive timeout. Please try again.',
        );
      case DioExceptionType.badCertificate:
        return const ServerFailure(
          errorMessage: 'Bad Certificate. Unable to verify server.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: dioException.response?.statusCode,
          responseData: dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
          errorMessage: 'Request to server was cancelled.',
        );
      case DioExceptionType.connectionError:
        return const ServerFailure(
          errorMessage: 'Connection error. Please check your internet.',
        );
      case DioExceptionType.unknown:
        return const ServerFailure(
          errorMessage: 'Unexpected error. Please try again.',
        );
    }
  }

  factory ServerFailure.fromResponse({
    required int? statusCode,
    required dynamic responseData,
  }) {
    if (statusCode == null) {
      return const ServerFailure(errorMessage: 'Unknown server error.');
    }

    if (responseData is Map<String, dynamic> && responseData['error'] != null) {
      return ServerFailure(errorMessage: responseData['error'].toString());
    }

    switch (statusCode) {
      case 400:
        return const ServerFailure(
          errorMessage: 'Invalid request. Please check your input.',
        );
      case 401:
        return const ServerFailure(
          errorMessage:
              'Unauthorized. Wrong email or password or not logged in.',
        );
      case 403:
        return const ServerFailure(
          errorMessage:
              'Forbidden. You do not have permission to perform this action.',
        );
      case 404:
        return const ServerFailure(
          errorMessage: 'Not found. User or resource does not exist.',
        );
      case 409:
        return const ServerFailure(
          errorMessage: 'Conflict. User with this email already exists.',
        );
      case 422:
        return const ServerFailure(
          errorMessage: 'Validation error. Check your submitted data.',
        );
      case 500:
        return const ServerFailure(
          errorMessage: 'Internal server error. An unexpected error occurred.',
        );
      case 503:
        return const ServerFailure(
          errorMessage: 'Service unavailable. Please try again later.',
        );
      default:
        return ServerFailure(errorMessage: 'Error occurred: $statusCode');
    }
  }
}

//firebase errors
class FirebaseFailure extends Failure {
  FirebaseFailure({required super.errorMessage});

  factory FirebaseFailure.fromFirebaseException({
    required FirebaseException exception,
  }) {
    switch (exception.code) {
      case 'network-request-failed':
        return FirebaseFailure(
          errorMessage: 'Network error. Please check your connection.',
        );
      case 'too-many-requests':
        return FirebaseFailure(
          errorMessage: 'Too many requests. Try again later.',
        );
      case 'user-not-found':
        return FirebaseFailure(
          errorMessage: 'User not found. Please check your credentials.',
        );
      case 'wrong-password':
        return FirebaseFailure(
          errorMessage: 'Wrong password. Please try again.',
        );
      case 'email-already-in-use':
        return FirebaseFailure(errorMessage: 'This email is already in use.');
      case 'invalid-email':
        return FirebaseFailure(errorMessage: 'The email address is not valid.');
      case 'weak-password':
        return FirebaseFailure(errorMessage: 'The password is too weak.');
      case 'operation-not-allowed':
        return FirebaseFailure(errorMessage: 'This operation is not allowed.');
      case 'user-disabled':
        return FirebaseFailure(
          errorMessage: 'This user account has been disabled.',
        );
      case 'requires-recent-login':
        return FirebaseFailure(
          errorMessage: 'Please log in again to perform this action.',
        );
      case 'invalid-verification-code':
        return FirebaseFailure(
          errorMessage: 'The verification code is invalid.',
        );
      case 'invalid-verification-id':
        return FirebaseFailure(errorMessage: 'The verification ID is invalid.');
      default:
        return FirebaseFailure(
          errorMessage: 'An unknown error occurred. Please try again.',
        );
    }
  }

  factory FirebaseFailure.fromFirebaseAuthException({
    required FirebaseAuthException exception,
  }) {
    switch (exception.code) {
      //Sign in/up Auth Errors
      case 'user-not-found':
        return FirebaseFailure(errorMessage: 'No user found with this email.');
      case 'wrong-password':
        return FirebaseFailure(errorMessage: 'Invalid password.');
      case 'account-exists-with-different-credential':
        return FirebaseFailure(
          errorMessage: 'Account exists with different credentials.',
        );
      case 'user-disabled':
        return FirebaseFailure(errorMessage: 'This user has been disabled.');
      case 'operation-not-allowed':
        return FirebaseFailure(errorMessage: 'Operation not allowed.');
      case 'invalid-email':
        return FirebaseFailure(errorMessage: 'Invalid Email address.');
      case 'email-already-in-use':
        return FirebaseFailure(errorMessage: 'Email already in use.');
      // Phone Number Authentication Errors
      case 'invalid-verification-code':
        return FirebaseFailure(
          errorMessage: 'The verification code is invalid.',
        );
      case 'invalid-verification-id':
        return FirebaseFailure(errorMessage: 'Invalid verification ID.');
      case 'invalid-phone-number':
        return FirebaseFailure(errorMessage: 'The phone number is invalid.');
      case 'missing-phone-number':
        return FirebaseFailure(errorMessage: 'Phone number is required.');
      case 'quota-exceeded':
        return FirebaseFailure(
          errorMessage: 'SMS quota for this project has been exceeded.',
        );
      case 'session-expired':
        return FirebaseFailure(
          errorMessage: 'The SMS code has expired. Please try again.',
        );
      case 'too-many-requests':
        return FirebaseFailure(
          errorMessage: 'Too many requests. Try again later.',
        );
      //Default Case
      default:
        return FirebaseFailure(errorMessage: 'Invalid credentials.');
    }
  }
}
