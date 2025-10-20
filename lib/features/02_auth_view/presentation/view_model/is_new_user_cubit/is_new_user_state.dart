abstract class IsNewUserState {}

class IsNewUserInitial extends IsNewUserState {}

class IsNewUserLoading extends IsNewUserState {}

class IsNewUserSuccess extends IsNewUserState {}

class IsNewUserFailure extends IsNewUserState {
  final String errorMessage;
  IsNewUserFailure({required this.errorMessage});
}

class IsOldUser extends IsNewUserState {}
