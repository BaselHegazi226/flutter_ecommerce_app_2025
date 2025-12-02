import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';

abstract class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileGetData extends EditProfileState {
  final UserModel userModel;

  EditProfileGetData({required this.userModel});
}

final class EditProfileLoadingData extends EditProfileState {}

final class EditProfileDataUpdating extends EditProfileState {
  final UserModel userModel;

  EditProfileDataUpdating({required this.userModel});
}

final class EditProfileUpdatingSuccess extends EditProfileState {
  final UserModel updatedUserModel;

  EditProfileUpdatingSuccess({required this.updatedUserModel});
}

final class EditProfileUpdatingFailure extends EditProfileState {
  final String errorMessage;

  EditProfileUpdatingFailure({required this.errorMessage});
}
