import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/user_info_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_firebaseStore.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/data/repo/profile_repo.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/data/repo/profile_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/presentation/view_model/user_info_cubit/user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCache userInfoCache = UserInfoCache();
  UserFirebaseStore userFirebaseStore = UserFirebaseStore();
  ProfileRepo profileRepo = ProfileRepoImpl();
  UserInfoCubit() : super(UserInfoInitial());

  Future<void> getUserInfo() async {
    emit(GetUserInfoLocalLoading());

    // أولاً نحاول نجيب البيانات من الكاش المحلي
    final localResult = await userInfoCache.getUser();

    await localResult.fold(
      (error) async {
        // لو فشل محليًا (مثلاً حصل خطأ في SharedPreferences)
        emit(
          GetUserInfoLocalFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (localUser) async {
        if (localUser != null) {
          // لو فيه بيانات محلية جاهزة → نعرضها فورًا
          emit(GetUserInfoLocalSuccess(userModel: localUser));
        } else {
          // لو مفيش بيانات محلية → نحاول نجيبها من Firebase
          final remoteResult = await userFirebaseStore.getUserFromFirebase();

          remoteResult.fold(
            (error) {
              emit(
                GetUserInfoFromFirestoreFailure(
                  errorMessage: error.errorMessage ?? 'unknown error',
                ),
              );
            },
            (remoteUser) async {
              if (remoteUser != null) {
                // نحفظها محليًا للمرة الجاية
                await userInfoCache.saveUser(userModel: remoteUser);
                emit(GetUserInfoFromFirestoreSuccess(userModel: remoteUser));
              } else {
                emit(
                  GetUserInfoFromFirestoreFailure(
                    errorMessage: 'no user found',
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await profileRepo.signOut();
    await result.fold(
      (error) async {
        return emit(SignOutFailure(errorMessage: error.errorMessage!));
      },
      (success) async {
        return emit(SignOutSuccess());
      },
    );
  }
}
