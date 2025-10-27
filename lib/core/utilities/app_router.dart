import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/features/01_splash_view/presentation/view/splash_view.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/sign_in_view.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/sign_up_view.dart';
import 'package:flutter_e_commerce_app_2025/features/03_main_view/main_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/category_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/category_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/home_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/product_details_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/cart_view.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/presentation/view/profile_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/05_cart_view/presentation/view/checkout_view.dart';
import '../helper/routes.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splashView, // يبدأ من التاب الأول
    routes: [
      GoRoute(
        path: Routes.splashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.loginView,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: Routes.registerView,
        builder: (context, state) => const SignUpView(),
      ),

      /// 🔹 ShellRoute يحتوي الـ MainView + BottomNavBar
      ShellRoute(
        builder: (context, state, child) {
          return MainView(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.homeView,
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: Routes.categoryView,
                builder: (context, state) {
                  final model = state.extra as CategoryModel;
                  return CategoryView(categoryModel: model);
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.cartView,
            builder: (context, state) => const CartView(),
            routes: [
              GoRoute(
                path: Routes.checkoutView,
                builder: (context, state) => const CheckoutView(),
              ),
            ],
          ),

          GoRoute(
            path: Routes.profileView,
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.productDetailsView,
        builder: (context, state) {
          final productId = state.extra as int;
          debugPrint('id from go router = $productId');
          return ProductDetailsView(productId: productId);
        },
      ),
    ],
  );
}
