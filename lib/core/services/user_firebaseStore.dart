import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';

import '../errors/failure.dart';

class UserFirebaseStore {
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('user');

  // Singleton
  static final UserFirebaseStore _instance = UserFirebaseStore._internal();
  UserFirebaseStore._internal();
  factory UserFirebaseStore() => _instance;

  Future<Either<Failure, void>> addUserToFirebase(UserModel userModel) async {
    try {
      await collectionReference.doc(userModel.id).set(userModel.toJson());
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<Either<Failure, UserModel?>> getUserFromFirebase(String userId) async {
    try {
      final data = await collectionReference.doc(userId).get();

      if (data.exists) {
        final Map<String, dynamic> json = data.data() as Map<String, dynamic>;
        final userinfo = UserModel.fromJson(json);
        return right(userinfo);
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<void> deleteUserFromFirebase(String id) async {
    await collectionReference.doc(id).delete();
  }
}
