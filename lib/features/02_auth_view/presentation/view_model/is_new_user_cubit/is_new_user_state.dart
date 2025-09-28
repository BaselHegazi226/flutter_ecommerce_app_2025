abstract class IsNewUserState {}

class IsNewUserInitial extends IsNewUserState {}

class IsNewUserLoading extends IsNewUserState {}

class IsNewUserSuccess extends IsNewUserState {
  final bool isNewUser;
  IsNewUserSuccess({required this.isNewUser});
}

class IsOldUser extends IsNewUserState {
  final bool isNewUser;
  IsOldUser({required this.isNewUser});
}
