import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utilities/init_method.dart';
import '../../../data/repo/auth_repo.dart';
import 'is_new_user_state.dart';

class IsNewUserCubit extends Cubit<IsNewUserState> {
  final AuthRepo authRepo;
  IsNewUserCubit({required this.authRepo}) : super(IsNewUserInitial());
  Future<void> isNewUser() async {
    emit(IsNewUserLoading());
    debugPrint('now in loading is a new user');
    final result = await authRepo.isNewUser();
    result.fold(
      (failure) {
        emit(
          IsNewUserFailure(
            errorMessage: failure.errorMessage ?? 'unknown error',
          ),
        );
      },
      (userIdSuccess) async {
        if (userIdSuccess == null) {
          debugPrint('result = $result');
          debugPrint('now in success is a new user');
          emit(IsNewUserSuccess());
        } else {
          debugPrint('now in success is a old user');
          //هنا بفتح الصناديق بتاعه المستخدم الخاص ب hive
          await initMethods(userId: userIdSuccess);
          emit(IsOldUser());
        }
      },
    );
  }
}
