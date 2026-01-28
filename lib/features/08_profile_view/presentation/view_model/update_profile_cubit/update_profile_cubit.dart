import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/update_profile_cubit/update_profile_state.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';

import '../../../domain/use_cases/profile_use_cases.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.updateProfileUseCase, this.userInfoCubit)
    : super(UpdateProfileInitial());

  final UpdateProfileUseCase updateProfileUseCase;
  final UserInfoCubit userInfoCubit;

  Future<void> updateProfile({
    final String? userName,
    final String? imageUrl,
  }) async {
    emit(UpdateProfileLoading());

    final result = await updateProfileUseCase.call(
      newUserName: userName,
      photoUrl: imageUrl,
    );

    result.fold(
      (error) {
        emit(UpdateProfileFailure(errorMessage: error.errorKey ?? 'unknown'));
      },
      (updatedUser) {
        // 🔥 السطر المهم جدًا
        userInfoCubit.updateUser(updatedUser);

        emit(UpdateProfileSuccess(updatedUser: updatedUser));
      },
    );
  }
}
