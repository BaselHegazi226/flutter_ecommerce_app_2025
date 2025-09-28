import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auth_repo.dart';
import 'is_new_user_state.dart';

class IsNewUserCubit extends Cubit<IsNewUserState> {
  final AuthRepo authRepo;
  IsNewUserCubit({required this.authRepo}) : super(IsNewUserInitial());
  Future<void> isNewUser() async {
    emit(IsNewUserLoading());
    debugPrint('now in loading is a new user');
    final result = authRepo.isNewUser();
    if (result) {
      debugPrint('result = $result');
      debugPrint('now in success is a new user');
      emit(IsNewUserSuccess(isNewUser: result));
    } else {
      debugPrint('now in success is a old user');
      emit(IsOldUser(isNewUser: result));
    }
  }
}
