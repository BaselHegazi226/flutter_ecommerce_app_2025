import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/cache/settings.dart';
import 'core/utilities/app_bloc_observer.dart';
import 'features/00_ecommerce_app/ecommerce_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await CacheHelper().init();
  final savedTheme = await CacheHelper().getData(
    key: CacheHelperKeys.keyThemeMode,
  );
  final savedLanguage = await CacheHelper().getData(
    key: CacheHelperKeys.keyLanguage,
  );
  Bloc.observer = AppBlocObserver();
  runApp(EcommerceApp(savedLanguage: savedLanguage, savedTheme: savedTheme));
}

//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Hive.initFlutter();
//   await CacheHelper().init();
//   final savedTheme = await CacheHelper().getData(
//     key: CacheHelperKeys.keyThemeMode,
//   );
//   final savedLanguage = await CacheHelper().getData(
//     key: CacheHelperKeys.keyLanguage,
//   );
//   Bloc.observer = AppBlocObserver();
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => EcommerceApp(
//         savedLanguage: savedLanguage,
//         savedTheme: savedTheme,
//       ), // Wrap your app
//     ),
//   );
// }
