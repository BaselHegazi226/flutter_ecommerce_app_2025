import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  //get userModel

  // 3. initialization مرة واحدة
  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> initialization() async {
    _instance.init();
  }

  Future<void> saveUser({required UserModel userModel}) async {
    try {
      var userModelJsonToString = jsonEncode(userModel.toJson());
      await _sharedPreferences!.setString(
        userModel.id.toString(),
        userModelJsonToString,
      );
      debugPrint('save local for user success');
      debugPrint('id = ${userModel.id}');
    } catch (e) {
      debugPrint('error = $e');
    }
  }

  Future<UserModel?> getUser({required String id}) async {
    var data = _sharedPreferences!.getString(id);

    if (data == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(data));
  }

  Future<void> deleteUser({required String id}) async {
    await _sharedPreferences!.remove(id);
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
