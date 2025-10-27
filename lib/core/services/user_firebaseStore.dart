import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';

import '../errors/failure.dart';

class UserFirebaseStore {
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('user');
  late String userId;
  //singleton to constructor
  static final UserFirebaseStore _instance = UserFirebaseStore._internal();
  //private constructor
  UserFirebaseStore._internal();
  //get singleton constructor
  factory UserFirebaseStore() => _instance;

  Future<Either<Failure, void>> addUserToFirebase(UserModel userModel) async {
    try {
      userId = userModel.id;
      await collectionReference.doc(userModel.id).set(userModel.toJson());
      debugPrint(
        'user Model from firebase add function= ${userModel.toJson()}',
      );
      return right(null);
    } catch (e) {
      debugPrint('error = $e');
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<Either<Failure, UserModel?>> getUserFromFirebase() async {
    try {
      final data = await collectionReference.doc(userId).get();
      if (data.exists) {
        final userinfo = UserModel.fromJson(data);
        return right(userinfo);
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<void> deleteUserFromFirebase({required String id}) async {
    await collectionReference.doc(id).delete();
  }
}
