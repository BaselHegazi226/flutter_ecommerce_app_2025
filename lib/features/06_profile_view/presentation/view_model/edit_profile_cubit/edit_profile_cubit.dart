import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/data/repo/profile_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';

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
        debugPrint(
          'image piked from device failure : ${error.errorMessage} ======================>',
        );
        emit(
          EditProfileUpdatingFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (imagePickerSuccess) async {
        final result = await userFirebaseStore.uploadImageToCloudinary(
          imagePath: imagePickerSuccess,
        );
        result.fold(
          (error) {
            debugPrint(
              'updated info failure : ${error.errorMessage} ======================>>',
            );
            emit(
              EditProfileUpdatingFailure(
                errorMessage: error.errorMessage ?? 'unknown error',
              ),
            );
          },
          (successUrl) async {
            debugPrint(
              'upload to cloudinary successfully ======================>',
            );
            _userModel = _userModel!.copyWith(newPhotoUrl: successUrl);
            if (_userModel != null) {
              debugPrint('updated info success ======================>>');
              emit(EditProfileDataUpdating(userModel: _userModel!));
            } else {
              debugPrint('No user found ======================>>');
              emit(EditProfileUpdatingFailure(errorMessage: 'No User Found'));
            }
          },
        );
      },
    );
  }

  updateUserName({String? newName}) async {
    if (_userModel == null) return;
    _userModel = _userModel!.copyWith(newName: newName);
    debugPrint('updated user name success ======================>>');
    emit(EditProfileDataUpdating(userModel: _userModel!));
  }

  Future<void> saveChanges() async {
    if (_userModel == null) return;

    emit(EditProfileLoadingData());

    final result = await profileRepo.updateUserInfo(newUserModel: _userModel!);

    result.fold(
      (error) {
        debugPrint(
          'updated info failure : ${error.errorMessage} ======================>',
        );
        emit(
          EditProfileUpdatingFailure(
            errorMessage: error.errorMessage ?? 'No user found',
          ),
        );
      },
      (_) async {
        debugPrint('updated all info success ======================>>');
        await userInfoCubit.getUserInfo();
        emit(EditProfileDataUpdating(userModel: _userModel!));
        emit(EditProfileUpdatingSuccess(updatedUserModel: _userModel!));
      },
    );
  }
}
