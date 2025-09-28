part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthSocialInitial extends AuthState {}

//google sign in
final class SignInWithGoogleInitial extends AuthState {}

final class SignInWithGoogleLoading extends AuthState {}

final class SignInWithGoogleFailure extends AuthState {
  final String errorMessage;
  SignInWithGoogleFailure({required this.errorMessage});
}

final class SignInWithGoogleSuccess extends AuthState {}

//facebook sign in
final class SignInWithFacebookInitial extends AuthState {}

final class SignInWithFacebookLoading extends AuthState {}

final class SignInWithFacebookFailure extends AuthState {
  final String errorMessage;
  SignInWithFacebookFailure({required this.errorMessage});
}

final class SignInWithFacebookSuccess extends AuthState {}

//sign in with email
final class SignInWithEmailInitial extends AuthState {}

final class SignInWithEmailLoading extends AuthState {}

final class SignInWithEmailFailure extends AuthState {
  final String errorMessage;
  SignInWithEmailFailure({required this.errorMessage});
}

final class SignInWithEmailSuccess extends AuthState {}

//sign up with email
final class SignUpWithEmailInitial extends AuthState {}

final class SignUpWithEmailLoading extends AuthState {}

final class SignUpWithEmailFailure extends AuthState {
  final String errorMessage;
  SignUpWithEmailFailure({required this.errorMessage});
}

final class SignUpWithEmailSuccess extends AuthState {}

//sign out
final class SignOutInitial extends AuthState {}

final class SignOutLoading extends AuthState {}

final class SignOutFailure extends AuthState {
  final String errorMessage;
  SignOutFailure({required this.errorMessage});
}

final class SignOutSuccess extends AuthState {}
