import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/profile_use_cases.dart';

part 'update_user_name_state.dart';

class UpdateUserNameCubit extends Cubit<UpdateUserNameState> {
  UpdateUserNameCubit(this.changeCurrentUserNameUseCase)
    : super(UpdateUserNameInitial());
  final ChangeCurrentUserNameUseCase changeCurrentUserNameUseCase;

  Future<void> changeCurrentUserName({required String? userName}) async {
    emit(UpdateUserNameLoading());
    final result = await changeCurrentUserNameUseCase.call(
      newUserName: userName,
    );
    result.fold(
      (error) {
        emit(UpdateUserNameFailure(errorMessage: error.errorKey ?? 'unknown'));
      },
      (userNameSuccess) {
        emit(UpdateUserNameSuccess(userName: userNameSuccess));
      },
    );
  }
}
