import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/data/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/cache/user_info_cache.dart';
import '../../../../core/errors/catch_error_handle.dart';
import '../../../02_auth_view/data/model/user_model.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final firebase = FirebaseAuth.instance;

      // 1) تسجيل الخروج من Firebase
      await firebase.signOut();

      // 2) حذف بيانات المستخدم من الكاش المحلي
      await UserInfoCacheImplement().deleteUser();

      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<Either<Failure, void>> updateUserInfo({
    required UserModel newUserModel,
  }) async {
    try {
      await UserInfoCacheImplement().updateUser(newUserModel: newUserModel);
      await UserServices().updateUserInfo(userModel: newUserModel);
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<Either<Failure, String>> pickImageFromDevice() async {
    try {
      //pick image from gallery
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        return right(image.path);
      } else {
        return left(
          CatchErrorHandle.catchBack(failure: 'failed pick image from device'),
        );
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}
