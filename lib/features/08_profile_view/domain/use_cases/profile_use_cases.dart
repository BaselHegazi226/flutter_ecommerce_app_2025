import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/features/03_auth_view/data/model/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../data/repo_impl/profile_repo_impl.dart';

class PickImageFromDeviceUseCase {
  PickImageFromDeviceUseCase(this.profileRepo);

  ProfileRepoImpl profileRepo;

  Future<Either<Failure, String>> call() {
    return profileRepo.pickImageFromDevice();
  }
}

class UploadImageToCloudniaryUseCase {
  UploadImageToCloudniaryUseCase(this.profileRepo);

  ProfileRepoImpl profileRepo;

  Future<Either<Failure, String>> call() {
    return profileRepo.prepareImageToUpload();
  }
}

class SignOutUseCase {
  SignOutUseCase(this.profileRepo);

  ProfileRepoImpl profileRepo;

  Future<Either<Failure, void>> call() {
    return profileRepo.signOut();
  }
}

class UpdateProfileUseCase {
  UpdateProfileUseCase(this.profileRepo);

  final ProfileRepoImpl profileRepo;

  Future<Either<Failure, UserModel>> call({
    String? newUserName,
    String? photoUrl,
  }) {
    return profileRepo.updateProfile(
      newUserName: newUserName,
      photoUrl: photoUrl,
    );
  }
}

class ChangeCurrentUserNameUseCase {
  ChangeCurrentUserNameUseCase(this.profileRepo);

  final ProfileRepoImpl profileRepo;

  Future<Either<Failure, String>> call({String? newUserName}) {
    return profileRepo.changeUserName(userName: newUserName);
  }
}

class UserInfoUseCase {}
