import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthSocialInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<SignInWithFacebookEvent>(_onSignInWithFacebookEvent);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('now in loading state');
    emit(SignInWithGoogleLoading());
    var result = await authRepo.signInWithGoogle();
    await result.fold(
      (error) async {
        return emit(SignInWithGoogleFailure(errorMessage: error.errorMessage!));
      },
      (success) async {
        return emit(SignInWithGoogleSuccess());
      },
    );
  }

  Future<void> _onSignInWithFacebookEvent(
    SignInWithFacebookEvent event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('now in loading state');
    emit(SignInWithFacebookLoading());
    var result = await authRepo.signInWithFacebook();
    await result.fold(
      (error) async {
        return emit(
          SignInWithFacebookFailure(errorMessage: error.errorMessage!),
        );
      },
      (success) async {
        return emit(SignInWithFacebookSuccess());
      },
    );
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignInWithEmailLoading());
    final result = await authRepo.signInWithEmail(
      email: event.email,
      password: event.password,
    );
    await result.fold(
      (error) async {
        return emit(SignInWithEmailFailure(errorMessage: error.errorMessage!));
      },
      (success) async {
        return emit(SignInWithEmailSuccess());
      },
    );
  }

  Future<void> _onSignUpWithEmail(
    SignUpWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignUpWithEmailLoading());
    final result = await authRepo.signUpWithEmail(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    await result.fold(
      (error) async {
        return emit(SignUpWithEmailFailure(errorMessage: error.errorMessage!));
      },
      (success) async {
        return emit(SignUpWithEmailSuccess());
      },
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(SignOutLoading());
    final result = await authRepo.signOut();
    await result.fold(
      (error) async {
        return emit(SignOutFailure(errorMessage: error.errorMessage!));
      },
      (success) async {
        return emit(SignOutSuccess());
      },
    );
  }
}
