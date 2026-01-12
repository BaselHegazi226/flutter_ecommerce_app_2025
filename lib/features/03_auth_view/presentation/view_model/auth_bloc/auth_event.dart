part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class SignInWithFacebookEvent extends AuthEvent {}

class SignInWithEmailEvent extends AuthEvent {
  final String email, password;
  SignInWithEmailEvent({required this.email, required this.password});
}

class SignUpWithEmailEvent extends AuthEvent {
  final String name, email, password;
  SignUpWithEmailEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
