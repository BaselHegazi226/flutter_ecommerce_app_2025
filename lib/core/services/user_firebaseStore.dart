import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';

class UserFirebaseStore {
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('user');
  //singleton to constructor
  static final UserFirebaseStore _instance = UserFirebaseStore._internal();
  //private constructor
  UserFirebaseStore._internal();
  //get singleton constructor
  factory UserFirebaseStore() => _instance;

  Future<void> addUserToFirebase(UserModel userModel) async {
    try {
      await collectionReference.doc(userModel.id).set(userModel.toJson());
      debugPrint(
        'user Model from firebase add function= ${userModel.toJson()}',
      );
    } catch (e) {
      debugPrint('error = $e');
    }
  }

  Future<UserModel?> getUserFromFirebase({required String id}) async {
    final data = await collectionReference.doc(id).get();
    if (data.exists) {
      final userinfo = UserModel.fromJson(data);
      return userinfo;
    }
    return null;
  }

  Future<void> deleteUserFromFirebase({required String id}) async {
    await collectionReference.doc(id).delete();
  }
}
