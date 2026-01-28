import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/cache/user_info_cache.dart';
import '../../../../core/errors/catch_error_handle.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/user_services.dart';
import '../../../03_auth_view/data/model/user_model.dart';
import '../../domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final UserServices userServices;
  final UserInfoCache userInfoCache;

  ProfileRepoImpl({required this.userServices, required this.userInfoCache});

  // ---------------- SIGN OUT ----------------
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await userInfoCache.deleteUser();
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  // ---------------- PICK IMAGE ----------------
  @override
  Future<Either<Failure, String>> pickImageFromDevice() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return left(CatchErrorHandle.catchBack(failure: 'Image not selected'));
      }

      return right(image.path);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  // ---------------- CURRENT USER ----------------
  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() async {
    try {
      final result = await userInfoCache.getUser();

      return result.fold((failure) => left(failure), (user) => right(user!));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorKey: e.toString()));
    }
  }

  // ---------------- UPDATE PROFILE ----------------
  @override
  Future<Either<Failure, UserModel>> updateProfile({
    String? newUserName,
    String? photoUrl,
  }) async {
    try {
      return await getCurrentUserData().then(
        (userEither) =>
            userEither.fold((failure) => left(failure), (currentUser) async {
              UserModel updatedUser = currentUser;

              // ---------- IMAGE ----------
              updatedUser = updatedUser.copyWith(newPhotoUrl: photoUrl);

              // ---------- NAME ----------
              final nameEither = await changeUserName(userName: newUserName);
              nameEither.fold((_) {}, (name) {
                updatedUser = updatedUser.copyWith(newName: name);
              });

              // ---------- SAVE ----------
              await userServices.updateUserInfo(userModel: updatedUser);
              await userInfoCache.updateUser(newUserModel: updatedUser);

              return right(updatedUser);
            }),
      );
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  // ---------------- IMAGE LOGIC ----------------
  @override
  Future<Either<Failure, String>> prepareImageToUpload() async {
    final pickEither = await pickImageFromDevice();

    return pickEither.fold(
      (_) async {
        // user didn't pick image → keep old one
        return getCurrentUserData().then(
          (userEither) => userEither.fold(
            (failure) => left(failure),
            (user) => right(user.photoUrl!),
          ),
        );
      },
      (imagePath) async {
        final uploadEither = await userServices.uploadImageToCloudinary(
          imagePath: imagePath,
        );

        return uploadEither.fold(
          (failure) => left(failure),
          (url) => right(url),
        );
      },
    );
  }

  // ---------------- NAME LOGIC ----------------
  @override
  Future<Either<Failure, String>> changeUserName({
    required String? userName,
  }) async {
    return getCurrentUserData().then(
      (userEither) => userEither.fold(
        (failure) => left(failure),
        (user) => right(userName ?? user.name),
      ),
    );
  }
}
