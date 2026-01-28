import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../03_auth_view/data/model/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, String>> pickImageFromDevice();

  Future<Either<Failure, String>> prepareImageToUpload();

  Future<Either<Failure, UserModel>> updateProfile({String? newUserName});

  Future<Either<Failure, String>> changeUserName({required String? userName});

  Future<Either<Failure, UserModel>> getCurrentUserData();
  //Future<Either<Failure, UserModel>> getUserInfo();
}
