part of 'update_user_name_cubit.dart';

@immutable
sealed class UpdateUserNameState {}

final class UpdateUserNameInitial extends UpdateUserNameState {}

final class UpdateUserNameLoading extends UpdateUserNameState {}

final class UpdateUserNameFailure extends UpdateUserNameState {
  final String errorMessage;

  UpdateUserNameFailure({required this.errorMessage});
}

final class UpdateUserNameSuccess extends UpdateUserNameState {
  final String userName;

  UpdateUserNameSuccess({required this.userName});
}
