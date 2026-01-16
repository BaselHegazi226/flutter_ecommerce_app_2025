import '../../../../03_auth_view/data/model/user_model.dart';

abstract class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileGetData extends EditProfileState {
  final UserModel userModel;

  EditProfileGetData({required this.userModel});
}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileDataUpdating extends EditProfileState {
  final UserModel userModel;

  EditProfileDataUpdating({required this.userModel});
}

final class EditProfileSuccess extends EditProfileState {
  final UserModel updatedUserModel;

  EditProfileSuccess({required this.updatedUserModel});
}

final class EditProfileFailure extends EditProfileState {
  final String errorMessage;

  EditProfileFailure({required this.errorMessage});
}
