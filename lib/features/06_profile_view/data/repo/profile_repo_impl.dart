import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/data/repo/profile_repo.dart';

import '../../../../core/cache/user_info_cache.dart';
import '../../../../core/errors/catch_error_handle.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final firebaseInstance = FirebaseAuth.instance;
      final user = firebaseInstance.currentUser;
      if (user != null) {
        await firebaseInstance.signOut();
        await deleteUser();
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<void> deleteUser() async {
    UserInfoCache().deleteUser();
  }
}
