import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/favourite_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_bloc_observer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:hive_flutter/hive_flutter.dart'; // ← الإضافة المهمة

import 'core/cache/user_info_cache.dart';
import 'core/helper/firebase_options.dart';
import 'features/00_ecommerce_app/ecommerce_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initMethods();
  Bloc.observer = AppBlocObserver();

  runApp(const EcommerceApp());
}

Future<void> initMethods() async {
  // ← الخطوة الجديدة والمهمة
  await UserInfoCache().initialization();
  //cart cache implement
  await Hive.initFlutter();
  final cartCacheImplement = CartCacheImplement(userId: 'user12345');
  await cartCacheImplement.init();

  //favourite cache implement
  final favouriteCacheImplement = FavouriteCacheImplement(userId: 'user12345');
  await favouriteCacheImplement.init();

  AppGet().setUp(
    cartCacheImplement: cartCacheImplement,
    favouriteCacheImplement: favouriteCacheImplement,
  );
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await initMethods();
//  Bloc.observer = AppBlocObserver();
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => EcommerceApp(), // Wrap your app
//     ),
//   );
// }
