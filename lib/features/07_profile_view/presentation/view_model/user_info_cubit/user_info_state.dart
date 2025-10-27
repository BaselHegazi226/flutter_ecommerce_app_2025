import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';

abstract class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}

final class GetUserInfoFromFirestoreInitial extends UserInfoState {}

final class GetUserInfoFromFirestoreLoading extends UserInfoState {}

final class GetUserInfoFromFirestoreFailure extends UserInfoState {
  final String errorMessage;

  GetUserInfoFromFirestoreFailure({required this.errorMessage});
}

final class GetUserInfoFromFirestoreSuccess extends UserInfoState {
  final UserModel userModel;

  GetUserInfoFromFirestoreSuccess({required this.userModel});
}

final class GetUserInfoLocalInitial extends UserInfoState {}

final class GetUserInfoLocalLoading extends UserInfoState {}

final class GetUserInfoLocalFailure extends UserInfoState {
  final String errorMessage;

  GetUserInfoLocalFailure({required this.errorMessage});
}

final class GetUserInfoLocalSuccess extends UserInfoState {
  final UserModel userModel;

  GetUserInfoLocalSuccess({required this.userModel});
}

final class SignOutInitial extends UserInfoState {}

final class SignOutLoading extends UserInfoState {}

final class SignOutFailure extends UserInfoState {
  final String errorMessage;

  SignOutFailure({required this.errorMessage});
}

final class SignOutSuccess extends UserInfoState {}
