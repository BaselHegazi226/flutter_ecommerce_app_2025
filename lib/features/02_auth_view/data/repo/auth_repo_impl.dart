import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_firebaseStore.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/repo/auth_repo.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/cache/user_info_cache.dart';
import '../../../../core/errors/catch_error_handle.dart';
import '../model/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, UserCredential>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(credential);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signInWithFacebook() async {
    debugPrint('now in login with facebook');
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      debugPrint('status code for login with facebook : ${loginResult.status}');
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
              loginResult.accessToken!.tokenString,
            );

        // Once signed in, return the UserCredential
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        final user = userCredential.user;
        if (user != null && userCredential.credential != null) {
          UserModel userModel = UserModel(
            id: user.uid,
            name: user.displayName ?? 'guest',
            email: user.email ?? 'guest',
            photoUrl: user.photoURL,
            provider: 'facebook',
          );
          final String userToken = userCredential.credential!.token.toString();
          await saveUser(userModel: userModel, userToken: userToken);
        }
        return right(userCredential);
      } else {
        debugPrint('status = ${loginResult.status}');
        return right(null);
      }
      // Create a credential from the access token
    } catch (e) {
      debugPrint('error = ${e.toString()}');
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      debugPrint('now in try ');

      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      await googleSignIn.signOut();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      // تسجيل الدخول في Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null && userCredential.credential != null) {
        UserModel userModel = UserModel(
          id: user.uid,
          name: user.displayName ?? 'guest',
          email: user.email ?? 'guest',
          photoUrl: user.photoURL,
          provider: 'google',
        );
        final String userToken = userCredential.credential!.token.toString();
        await saveUser(userModel: userModel, userToken: userToken);
      }
      //save user data

      // خزن حالة المستخدم
      return right(userCredential);
    } catch (e) {
      debugPrint('error=$e');
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
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        debugPrint('user = null');
      }
      if (user != null) {
        UserModel userModel = UserModel(
          id: user.uid,
          name: name,
          email: email,
          provider: 'email and password',
          photoUrl: user.photoURL,
        );
        final String? userToken = await user.getIdToken(true);
        await saveUser(
          userModel: userModel,
          userToken: userToken ?? 'new user',
        );
      }
      return right(userCredential);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updatePassword() {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyCode() {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String?>> isNewUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      // لو مفيش يوزر حالياً (يعني سجل خروج)
      if (user == null) {
        return right(null);
      } else {
        return right(user.uid);
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final firebaseInstance = FirebaseAuth.instance;
      final user = firebaseInstance.currentUser;
      if (user != null) {
        await firebaseInstance.signOut();
        await deleteUser(userId: user.uid);
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  Future<void> saveUser({
    required UserModel userModel,
    required String userToken,
  }) async {
    //save user data to shared preference
    await UserInfoCache().saveUser(userModel: userModel);
    //save user data to firebase
    await UserFirebaseStore().addUserToFirebase(userModel);
  }

  Future<void> deleteUser({required String userId}) async {
    UserInfoCache().deleteUser(id: userId);
  }
}
