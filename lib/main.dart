import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/helper/firebase_options.dart';
import 'core/utilities/app_bloc_observer.dart';
import 'features/00_ecommerce_app/ecommerce_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  runApp(const EcommerceApp());
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
