import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/sign_out_cubit/sign_out_state.dart';

import '../../../domain/use_cases/profile_use_cases.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this.signOutUseCase) : super(SignOutInitial());
  final SignOutUseCase signOutUseCase;

  Future<void> signOut() async {
    emit(SignOutLoading());

    final result = await signOutUseCase.call();

    result.fold(
      (error) {
        emit(SignOutFailure(errorMessage: error.errorKey ?? 'sign out error'));
      },
      (_) {
        emit(SignOutSuccess());
      },
    );
  }
}
