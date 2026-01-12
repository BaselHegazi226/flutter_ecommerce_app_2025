import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/utilities/init_method.dart';
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
  }

  Future<void> _onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('now in loading state');
    emit(SignInWithGoogleLoading());
    final result = await authRepo.signInWithGoogle();
    await result.fold(
      (error) async {
        return emit(SignInWithGoogleFailure(errorMessage: error.errorKey!));
      },
      (success) async {
        final user = success.user;
        if (user != null) {
          await initMethods(userId: user.uid);
        }
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
    final result = await authRepo.signInWithFacebook();
    await result.fold(
      (error) async {
        return emit(SignInWithFacebookFailure(errorMessage: error.errorKey!));
      },
      (success) async {
        final userCredential = success;
        if (userCredential != null) {
          final user = userCredential.user;
          if (user != null) {
            await initMethods(userId: user.uid);
          }
        }
        return emit(SignInWithFacebookSuccess());
      },
    );
  }
  //طيب في حال تسجيل الدخول احنا تحققنا اصلا من فكره هل المستخدم موجود ولا لأ لو موجود يعني
  // عمل قبل كده sign up يبقى كده نفتح صناديقه
  // علطول من خلال isNewUserCubit لكن غير كده
  // هيروح لعمليه ال sign up ثم تتفتح بعدما ما يعمل تسجيل دخول كمستخدم جديد

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
        return emit(SignInWithEmailFailure(errorMessage: error.errorKey!));
      },
      (success) async {
        final user = success.user;
        if (user != null) {
          await initMethods(userId: user.uid);
        }
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
        return emit(SignUpWithEmailFailure(errorMessage: error.errorKey!));
      },
      (success) async {
        final user = success.user;
        if (user != null) {
          await initMethods(userId: user.uid);
        }
        return emit(SignUpWithEmailSuccess());
      },
    );
  }
}
