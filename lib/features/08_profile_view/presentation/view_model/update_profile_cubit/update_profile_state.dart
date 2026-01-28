import '../../../../03_auth_view/data/model/user_model.dart';

sealed class UpdateProfileState {}

/// 1️⃣ الحالة الابتدائية
final class UpdateProfileInitial extends UpdateProfileState {}

/// 2️⃣ أثناء التحديث
final class UpdateProfileLoading extends UpdateProfileState {}

/// 3️⃣ النجاح
final class UpdateProfileSuccess extends UpdateProfileState {
  final UserModel updatedUser;

  UpdateProfileSuccess({required this.updatedUser});
}

/// 4️⃣ الفشل
final class UpdateProfileFailure extends UpdateProfileState {
  final String errorMessage;

  UpdateProfileFailure({required this.errorMessage});
}
