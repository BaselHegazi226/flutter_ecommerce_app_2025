import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:http/http.dart' as http;

import '../../features/03_auth_view/data/model/user_model.dart';
import '../errors/failure.dart';

class UserServices {
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('user');

  // Singleton
  static final UserServices _instance = UserServices._internal();

  UserServices._internal();

  factory UserServices() => _instance;

  Future<Either<Failure, void>> addUserToFirebase(UserModel userModel) async {
    try {
      await collectionReference.doc(userModel.id).set(userModel.toJson());
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<Either<Failure, UserModel?>> updateUserInfo({
    required UserModel userModel,
  }) async {
    try {
      // UserModel independentUserModel = UserModel.fromJson(userModel.toJson());
      // UserModel updateUserModel = independentUserModel.copyWith(
      //   newName: userModel.name,
      //   newEmail: userModel.email,
      //   newPhotoUrl: userModel.photoUrl,
      // );
      await collectionReference.doc(userModel.id).update(userModel.toJson());
      debugPrint('user model = ${userModel.toJson()}');
      return right(userModel);
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

  Future<Either<Failure, String>> uploadImageToCloudinary({
    required String? imagePath,
  }) async {
    try {
      if (imagePath != null) {
        //prepare vars to upload image to cloudinary
        const String cloudinaryName = 'dxg5ddozd';
        const String uploadPreset = 'flutter_ecommerce2025_preset';
        //make request to upload image path
        final request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "https://api.cloudinary.com/v1_1/$cloudinaryName/image/upload",
          ),
        );
        //define upload preset
        request.fields['upload_preset'] = uploadPreset;
        // add image to sever
        request.files.add(await http.MultipartFile.fromPath('file', imagePath));
        // accept response
        final response = await request.send();
        //accept response body after response
        final responseBody = await http.Response.fromStream(response);
        if (response.statusCode == 200) {
          //convert path to url
          final url = jsonDecode(responseBody.body)['secure_url'];
          //return url
          return right(url);
        } else {
          return left(
            CatchErrorHandle.catchBack(
              failure:
                  'Cloudinary upload failed: ${responseBody.body}=============>',
            ),
          );
        }
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
