import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 مهم لإحضار uid الحالي
import 'package:flutter_e_commerce_app_2025/core/cache/user_info_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_firebaseStore.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_state.dart';

import '../../../data/repo/profile_repo.dart';
import '../../../data/repo/profile_repo_impl.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final UserInfoCache userInfoCache = UserInfoCache();
  final UserFirebaseStore userFirebaseStore = UserFirebaseStore();
  final ProfileRepo profileRepo = ProfileRepoImpl();

  UserInfoCubit() : super(UserInfoInitial());

  // -------------------------------------------------------------
  //  🔥 getUserInfo
  // -------------------------------------------------------------
  Future<void> getUserInfo() async {
    emit(GetUserInfoLocalLoading());

    // 1) إجلب البيانات من الكاش المحلي
    final localResult = await userInfoCache.getUser();

    await localResult.fold(
      (error) async {
        emit(
          GetUserInfoLocalFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (localUser) async {
        if (localUser != null) {
          // 2) إذا الكاش يحتوي بيانات، نعرضها فوراً
          emit(GetUserInfoLocalSuccess(userModel: localUser));
        } else {
          // 3) نجيب اليوزر الحالي من FirebaseAuth
          final currentUser = FirebaseAuth.instance.currentUser;

          if (currentUser == null) {
            emit(
              GetUserInfoFromFirestoreFailure(
                errorMessage: 'no logged in user',
              ),
            );
            return;
          }

          // 4) نجيب بياناته من Firestore
          final remoteResult = await userFirebaseStore.getUserFromFirebase(
            currentUser.uid,
          );

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
                // 5) نخزن البيانات محليًا للمرة القادمة
                await userInfoCache.saveUser(userModel: remoteUser);

                emit(GetUserInfoFromFirestoreSuccess(userModel: remoteUser));
              } else {
                emit(
                  GetUserInfoFromFirestoreFailure(
                    errorMessage: 'no user found in firestore',
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  // -------------------------------------------------------------
  //  🔥 signOut
  // -------------------------------------------------------------
  Future<void> signOut() async {
    emit(SignOutLoading());

    final result = await profileRepo.signOut();

    result.fold(
      (error) {
        emit(
          SignOutFailure(errorMessage: error.errorMessage ?? 'sign out error'),
        );
      },
      (_) {
        emit(SignOutSuccess());
      },
    );
  }
}
