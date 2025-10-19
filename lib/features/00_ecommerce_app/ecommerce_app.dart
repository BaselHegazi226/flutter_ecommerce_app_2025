import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../../core/utilities/app_router.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});
  //Ecommerce
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      ),
    );
  }
}
