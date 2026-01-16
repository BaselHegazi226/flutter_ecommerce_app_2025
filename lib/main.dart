import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/cache/settings.dart';
import 'core/utilities/app_bloc_observer.dart';
import 'features/0__ecommerce_app/ecommerce_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Cloudinary.fromCloudName(cloudName: 'flutter_ecommerce_app_demo');
  await Hive.initFlutter();
  await CacheHelper().init();
  final savedTheme = await CacheHelper().getData(
    key: CacheHelperKeys.keyThemeMode,
  );
  final savedLanguage = await CacheHelper().getData(
    key: CacheHelperKeys.keyLanguage,
  );
  Bloc.observer = AppBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(EcommerceApp(savedLanguage: savedLanguage, savedTheme: savedTheme));
}

//
// import 'package:cloudinary_url_gen/cloudinary.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/adapters.dart';
//
// import 'core/cache/settings.dart';
// import 'core/utilities/app_bloc_observer.dart';
// import 'features/0__ecommerce_app/ecommerce_app.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   Cloudinary.fromCloudName(cloudName: 'flutter_ecommerce_app_demo');
//   await Hive.initFlutter();
//   await CacheHelper().init();
//   final savedTheme = await CacheHelper().getData(
//     key: CacheHelperKeys.keyThemeMode,
//   );
//   final savedLanguage = await CacheHelper().getData(
//     key: CacheHelperKeys.keyLanguage,
//   );
//   Bloc.observer = AppBlocObserver();
//
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
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
