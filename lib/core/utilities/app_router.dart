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
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/edit_profile_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/favourite_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/order_history_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/settings_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/shipping_address_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/05_cart_view/presentation/view/checkout_view.dart';
import '../../features/06_profile_view/presentation/view/profile_view.dart';
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
            builder: (context, state) {
              return const CartView();
            },
            routes: [
              GoRoute(
                path: Routes.checkoutView,
                builder: (context, state) {
                  final providers = state.extra as Map<String, dynamic>;
                  final bloc = providers['cart_bloc'] as CartBloc;
                  final cubit = providers['get_cart_cubit'] as GetCartCubit;
                  return CheckoutView(cartBloc: bloc, getCartCubit: cubit);
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.profileView,
            builder: (context, state) => const ProfileView(),
            routes: [
              GoRoute(
                path: Routes.editProfileView,
                builder: (context, state) => const EditProfileView(),
              ),
              GoRoute(
                path: Routes.orderHistoryView,
                builder: (context, state) => const OrderHistoryView(),
              ),
              GoRoute(
                path: Routes.settingsView,
                builder: (context, state) => const SettingsView(),
              ),
              GoRoute(
                path: Routes.shippingAddressView,
                builder: (context, state) => const ShippingAddressView(),
              ),
              GoRoute(
                path: Routes.favoriteView,
                builder: (context, state) => const FavouriteView(),
              ),
            ],
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
