import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/cache/user_info_cache.dart';
import '../../../../core/errors/catch_error_handle.dart';
import '../model/user_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final UserServices _userServices = UserServices();
  final UserInfoCacheImplement _userCache = UserInfoCacheImplement();

  @override
  Future<Either<Failure, UserCredential>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await _handleUserAfterLogin(userCredential);

      return right(userCredential);
    } on FirebaseAuthException catch (exception) {
      return left(FirebaseFailure.fromFirebaseException(exception: exception));
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status != LoginStatus.success) {
        return right(null);
      }

      final credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      await _handleUserAfterLogin(userCredential);

      return right(userCredential);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      await googleSignIn.signOut();

      final googleUser = await googleSignIn.authenticate(scopeHint: ['email']);

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      await _handleUserAfterLogin(userCredential);

      return right(userCredential);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user!;
      final userModel = UserModel(
        id: user.uid,
        name: name,
        email: email,
        photoUrl: user.photoURL,
        provider: 'email',
      );

      await _userServices.addUserToFirebase(userModel);
      await _userCache.saveUser(userModel: userModel);

      return right(userCredential);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  /// ================== 🔥 أهم جزء ==================
  Future<void> _handleUserAfterLogin(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user == null) return;

    // 1️⃣ حاول تجيب المستخدم من Firestore
    final remoteResult = await _userServices.getUserFromFirebase(user.uid);

    await remoteResult.fold(
      (_) async {
        // ❌ حصل error → اعمل fallback بإنشاء مستخدم
        final newUser = _mapFirebaseUserToModel(user);
        await _userServices.addUserToFirebase(newUser);
        await _userCache.saveUser(userModel: newUser);
      },
      (remoteUser) async {
        if (remoteUser != null) {
          // ✅ مستخدم موجود → استخدم بياناته (الصورة المعدلة محفوظة)
          await _userCache.saveUser(userModel: remoteUser);
        } else {
          // 🆕 مستخدم جديد
          final newUser = _mapFirebaseUserToModel(user);
          await _userServices.addUserToFirebase(newUser);
          await _userCache.saveUser(userModel: newUser);
        }
      },
    );
  }

  UserModel _mapFirebaseUserToModel(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? 'guest',
      email: user.email ?? 'guest',
      photoUrl: user.photoURL,
      provider: user.providerData.isNotEmpty
          ? user.providerData.first.providerId
          : 'unknown',
    );
  }

  // ================== باقي الدوال بدون تغيير ==================

  @override
  Future<Either<Failure, String?>> isNewUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return right(user?.uid);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword() => throw UnimplementedError();

  @override
  Future<Either<Failure, bool>> updatePassword() => throw UnimplementedError();

  @override
  Future<Either<Failure, bool>> verifyCode() => throw UnimplementedError();

  @override
  Future<Either<Failure, bool>> verifyEmail() => throw UnimplementedError();
}
