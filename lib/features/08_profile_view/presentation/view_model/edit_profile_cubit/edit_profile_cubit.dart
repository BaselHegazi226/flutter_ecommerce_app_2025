import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';

import '../../../../03_auth_view/data/model/user_model.dart';
import '../../../data/repo/profile_repo_impl.dart';
import '../user_info_cubit/user_info_cubit.dart';
import '../user_info_cubit/user_info_state.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepoImpl profileRepo = ProfileRepoImpl();
  final UserServices userFirebaseStore = UserServices();
  final UserInfoCubit userInfoCubit;

  EditProfileCubit({required this.userInfoCubit}) : super(EditProfileInitial());
  UserModel? _userModel;

  UserModel? get getUserModel => _userModel;

  void getCurrentUserData() {
    final state = userInfoCubit.state;
    if (state is GetUserInfoLocalSuccess) {
      _userModel = state.userModel;
      debugPrint('get user info success from local ======================>');
    } else if (state is GetUserInfoFromFirestoreSuccess) {
      debugPrint('get user info success from firebase ======================>');
      _userModel = state.userModel;
    }

    if (_userModel != null) {
      emit(EditProfileDataUpdating(userModel: _userModel!));
    }
  }

  prepareImageToUpload() async {
    final result = await profileRepo.pickImageFromDevice();
    result.fold(
      (error) {
        emit(
          EditProfileFailure(errorMessage: error.errorKey ?? 'unknown error'),
        );
      },
      (imagePickerSuccess) async {
        final result = await userFirebaseStore.uploadImageToCloudinary(
          imagePath: imagePickerSuccess,
        );
        result.fold(
          (error) {
            emit(
              EditProfileFailure(
                errorMessage: error.errorKey ?? 'unknown error',
              ),
            );
          },
          (successUrl) async {
            _userModel = _userModel!.copyWith(newPhotoUrl: successUrl);
            if (_userModel != null) {
              emit(EditProfileDataUpdating(userModel: _userModel!));
            } else {
              emit(EditProfileFailure(errorMessage: 'No User Found'));
            }
          },
        );
      },
    );
  }

  updateUserName({String? newName}) async {
    if (_userModel == null) return;
    _userModel = _userModel!.copyWith(newName: newName);
    emit(EditProfileDataUpdating(userModel: _userModel!));
  }

  Future<void> saveChanges() async {
    if (_userModel == null) return;

    emit(EditProfileLoading());

    final result = await profileRepo.updateUserInfo(newUserModel: _userModel!);

    result.fold(
      (error) {
        emit(
          EditProfileFailure(errorMessage: error.errorKey ?? 'No user found'),
        );
      },
      (_) async {
        await userInfoCubit.getUserInfo();
        emit(EditProfileDataUpdating(userModel: _userModel!));
        emit(EditProfileSuccess(updatedUserModel: _userModel!));
      },
    );
  }
}
