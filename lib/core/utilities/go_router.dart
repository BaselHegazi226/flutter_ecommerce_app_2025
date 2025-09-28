import 'package:flutter_e_commerce_app_2025/features/01_splash_view/presentation/view/splash_view.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/sign_in_view.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/sign_up_view.dart';
import 'package:flutter_e_commerce_app_2025/features/03_home_view/presentation/view/home_view.dart';
import 'package:go_router/go_router.dart';

import '../helper/routes.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.homeView,
    routes: [
      GoRoute(
        path: Routes.splashView,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: Routes.loginView,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: Routes.registerView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: Routes.homeView,
        builder: (context, state) {
          return const HomeView();
        },
      ),
    ],
  );
}
