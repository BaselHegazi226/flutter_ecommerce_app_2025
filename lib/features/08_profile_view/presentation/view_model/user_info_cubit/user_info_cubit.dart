import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 مهم لإحضار uid الحالي
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/user_info_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/user_info_cubit/user_info_state.dart';

import '../../../../03_auth_view/data/model/user_model.dart';
import '../../../data/repo_impl/profile_repo_impl.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final UserInfoCacheImplement userInfoCache = UserInfoCacheImplement();
  final UserServices userFirebaseStore = UserServices();
  final ProfileRepoImpl profileRepo;

  UserInfoCubit(this.profileRepo) : super(UserInfoInitial());

  Future<UserModel?> getUserInfo() async {
    emit(GetUserInfoLocalLoading());

    // 1) إجلب البيانات من الكاش المحلي
    final localResult = await userInfoCache.getUser();

    await localResult.fold(
      (error) async {
        emit(
          GetUserInfoLocalFailure(
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (localUserSuccess) async {
        if (localUserSuccess != null) {
          // 2) إذا الكاش يحتوي بيانات، نعرضها فوراً
          emit(GetUserInfoLocalSuccess(userModel: localUserSuccess));
          debugPrint('user info local = ${localUserSuccess.toJson()}');
          return (localUserSuccess);
        } else {
          // 3) نجيب اليوزر الحالي من FirebaseAuth
          final currentUser = FirebaseAuth.instance.currentUser;

          if (currentUser == null) {
            emit(
              GetUserInfoFromFirestoreFailure(
                errorMessage: 'no logged in user',
              ),
            );
            return null;
          }

          // 4) نجيب بياناته من Firestore
          final remoteResult = await userFirebaseStore.getUserFromFirebase(
            currentUser.uid,
          );

          remoteResult.fold(
            (error) {
              emit(
                GetUserInfoFromFirestoreFailure(
                  errorMessage: error.errorKey ?? 'unknown error',
                ),
              );
            },
            (remoteUser) async {
              if (remoteUser != null) {
                // 5) نخزن البيانات محليًا للمرة القادمة
                await userInfoCache.saveUser(userModel: remoteUser);
                debugPrint('user info local = ${remoteUser.toJson()}');
                emit(GetUserInfoFromFirestoreSuccess(userModel: remoteUser));
                return (remoteUser);
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
    return null;
  }

  Future<void> updateUser(UserModel updatedUser) async {
    // 1️⃣ خزّن في الكاش
    await userInfoCache.saveUser(userModel: updatedUser);

    // 2️⃣ اعمل emit مباشر
    emit(GetUserInfoLocalSuccess(userModel: updatedUser));
  }
}
