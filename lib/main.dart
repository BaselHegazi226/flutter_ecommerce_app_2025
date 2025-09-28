import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/cache/user_info_cache.dart';
import 'core/helper/firebase_options.dart';
import 'features/00_ecommerce_app/ecommerce_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initMethods();
  runApp(const EcommerceApp());
}

Future<void> initMethods() async {
  await UserInfoCache().initialization();
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await initMethods();
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => EcommerceApp(), // Wrap your app
//     ),
//   );
// }
