import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/adapter_identifiers.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/02_auth_view/data/model/user_model.dart';

class UserInfoCache {
  // 1. Singleton pattern
  static final UserInfoCache _instance = UserInfoCache._internal();
  factory UserInfoCache() => _instance;
  UserInfoCache._internal();

  // 2. shared preference instance (nullable في البداية)
  SharedPreferences? _sharedPreferences;

  // 3. initialization مرة واحدة
  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<Either<Failure, void>> saveUser({required UserModel userModel}) async {
    try {
      //save user id
      _sharedPreferences!.setString('current_user', userModel.id);
      //save user model as string
      var userModelJsonToString = jsonEncode(userModel.toJson());
      await _sharedPreferences!.setString(
        'current_user${userModel.id}',
        userModelJsonToString,
      );
      return right(null);
    } catch (e) {
      debugPrint('error = $e');
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<Either<Failure, UserModel?>> getUser() async {
    try {
      final id = _sharedPreferences!.getString('current_user');
      if (id == null) return right(null);

      final data = _sharedPreferences!.getString('current_user$id');
      if (data == null) return right(null);
      final userModel = UserModel.fromJson(jsonDecode(data));
      return right(userModel);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<void> deleteUser() async {
    final id = _sharedPreferences!.getString('current_user');
    if (id != null) {
      await _sharedPreferences!.remove('current_user$id');
      await _sharedPreferences!.remove('current_user');
    }
  }
}

class UserCacheInfoHive {
  static final _instance = UserCacheInfoHive._internal();
  factory UserCacheInfoHive() => _instance;
  UserCacheInfoHive._internal();
  Box<UserModel>? userInfoBox;
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.userModelAdapter)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isBoxOpen('userInfo')) {
      userInfoBox = await Hive.openBox('userInfo');
    }
  }

  Future<void> initialization() async {
    await _instance.init();
  }

  Future<void> saveUser({required UserModel userModel}) async {
    await userInfoBox!.put(userModel.id.toString(), userModel);
  }

  Future<UserModel?> getUserInfo({required String id}) async {
    final userModel = userInfoBox!.get(id);
    return userModel;
  }

  Future<void> clearUser({required String id}) async {
    await userInfoBox!.delete(id);
  }
}

//
// class UserTokenCache {
//   static final _instance = UserTokenCache._internal();
//   factory UserTokenCache() => _instance;
//   UserTokenCache._internal();
//
//   FlutterSecureStorage? _flutterSecureStorage;
//   Future<void> init() async {
//     _flutterSecureStorage ??= FlutterSecureStorage();
//   }
//
//   Future<void> initialization() async {
//     await _instance.init();
//   }
//
//   Future<void> saveUserToken({
//     required String id,
//     required String userToken,
//   }) async {
//     debugPrint('id from save token = $id');
//     debugPrint('token = $userToken');
//     final idKey = hashSha256(id);
//     debugPrint('id after key hash = $idKey');
//     await _flutterSecureStorage!.write(key: idKey, value: userToken);
//   }
//
//   Future<String?> getUserToken({required String id}) async {
//     final key = hashSha256(id);
//     var userToken = await _flutterSecureStorage!.read(key: key);
//     return userToken;
//   }
//
//   Future<void> clearUserToken({required String id}) async {
//     final key = hashSha256(id);
//     await _flutterSecureStorage!.delete(key: key);
//   }
// }
//
// String hashSha256(String input) {
//   final bytes = utf8.encode(input); // تحويل النص لبايتس
//   final digest = sha256.convert(bytes); // حساب ال-hash
//   final digestToString = digest.toString();
//   debugPrint('digest = $digestToString');
//   return digestToString;
// }
