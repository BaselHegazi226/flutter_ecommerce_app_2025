import 'package:flutter_e_commerce_app_2025/features/01_splash_view/presentation/view/splash_view.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/login_view.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/register_view.dart';
import 'package:flutter_e_commerce_app_2025/features/03_main_view/main_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/home_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/product_details_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/show_all_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/cart_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/checkout_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/about_us_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/edit_profile_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/favourite_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/order_history_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/profile_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/settings_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/shipping_address_view.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/presentation/view/search_view.dart';
import 'package:go_router/go_router.dart';

import '../helper/app_transitions.dart';
import '../helper/routes.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splashView,
    routes: [
      /// Splash
      GoRoute(path: Routes.splashView, builder: (_, __) => const SplashView()),

      /// Auth
      GoRoute(
        path: Routes.loginView,
        pageBuilder: (context, state) => AppTransitions.fadeScale(
          key: state.pageKey,
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: Routes.registerView,
        pageBuilder: (context, state) => AppTransitions.fade(
          key: state.pageKey,
          child: const RegisterView(),
        ),
      ),

      /// Main Shell
      ShellRoute(
        builder: (context, state, child) => MainView(child: child),
        routes: [
          /// Home
          GoRoute(
            path: Routes.homeView,
            pageBuilder: (context, state) => AppTransitions.fadeScale(
              child: const HomeView(),
              key: state.pageKey,
            ),
            routes: [
              GoRoute(
                path: Routes.showAllView,
                pageBuilder: (context, state) => AppTransitions.fade(
                  key: state.pageKey,
                  child: const ShowAllView(),
                ),
              ),
            ],
          ),

          /// Search
          GoRoute(
            path: Routes.searchView,
            pageBuilder: (context, state) => AppTransitions.fadeScale(
              child: const SearchView(),
              key: state.pageKey,
            ),
          ),

          /// Cart
          GoRoute(
            path: Routes.cartView,
            pageBuilder: (context, state) => AppTransitions.fadeScale(
              child: const CartView(),
              key: state.pageKey,
            ),
            routes: [
              GoRoute(
                path: Routes.checkoutView,
                pageBuilder: (context, state) {
                  final data = state.extra as Map<String, dynamic>;
                  return AppTransitions.slideX(
                    key: state.pageKey,
                    child: CheckoutView(
                      cartBloc: data['cart_bloc'] as CartBloc,
                      getCartCubit: data['get_cart_cubit'] as GetCartCubit,
                    ),
                  );
                },
              ),
            ],
          ),

          /// Profile
          GoRoute(
            path: Routes.profileView,
            pageBuilder: (context, state) => AppTransitions.fadeScale(
              child: const ProfileView(),
              key: state.pageKey,
            ),
            routes: [
              GoRoute(
                path: Routes.editProfileView,
                pageBuilder: (context, state) => AppTransitions.slideX(
                  key: state.pageKey,
                  child: EditProfileView(
                    userInfoCubit: state.extra as UserInfoCubit,
                  ),
                ),
              ),
              GoRoute(
                path: Routes.settingsView,
                pageBuilder: (context, state) => AppTransitions.slideX(
                  key: state.pageKey,
                  child: const SettingsView(),
                ),
              ),
              GoRoute(
                path: Routes.orderHistoryView,
                pageBuilder: (context, state) => AppTransitions.slideX(
                  key: state.pageKey,
                  child: const OrderHistoryView(),
                ),
              ),
              GoRoute(
                path: Routes.shippingAddressView,
                pageBuilder: (context, state) => AppTransitions.slideX(
                  key: state.pageKey,
                  child: const ShippingAddressView(),
                ),
              ),
              GoRoute(
                path: Routes.favoriteView,
                pageBuilder: (context, state) => AppTransitions.slideX(
                  key: state.pageKey,
                  child: const FavouriteView(),
                ),
              ),
              GoRoute(
                path: Routes.aboutUsView,
                pageBuilder: (context, state) => AppTransitions.slideX(
                  key: state.pageKey,
                  child: const AboutUsView(),
                ),
              ),
            ],
          ),
        ],
      ),

      /// Product Details
      GoRoute(
        path: Routes.productDetailsView,
        pageBuilder: (context, state) => AppTransitions.fadeScale(
          key: state.pageKey,
          child: ProductDetailsView(productId: state.extra as int),
        ),
      ),
    ],
  );
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_e_commerce_app_2025/features/01_splash_view/presentation/view/splash_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/login_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/register_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/03_main_view/main_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/home_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/product_details_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/show_all_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/cart_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
// import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/about_us_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/edit_profile_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/favourite_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/order_history_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/settings_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/shipping_address_view.dart';
// import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
// import 'package:flutter_e_commerce_app_2025/features/07_search_view/presentation/view/search_view.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../features/05_cart_view/presentation/view/checkout_view.dart';
// import '../../features/06_profile_view/presentation/view/profile_view.dart';
// import '../helper/routes.dart';
//
// abstract class AppRouter {
//   static final router = GoRouter(
//     initialLocation: Routes.splashView, // يبدأ من التاب الأول
//     routes: [
//       GoRoute(
//         path: Routes.splashView,
//         builder: (context, state) => const SplashView(),
//       ),
//       GoRoute(
//         path: Routes.loginView,
//         //builder: (context, state) => const LoginView(),
//         pageBuilder: (context, state) => CustomTransitionPage(
//           child: const LoginView(),
//           transitionDuration: const Duration(seconds: 5),
//           key: state.pageKey,
//           transitionsBuilder: (context, animation, secondAnimation, child) {
//             return FadeTransition(
//               opacity: CurveTween(
//                 curve: Curves.easeInOutCirc,
//               ).animate(animation),
//               child: child,
//             );
//           },
//         ),
//       ),
//       GoRoute(
//         path: Routes.registerView,
//         builder: (context, state) => const RegisterView(),
//       ),
//
//       /// 🔹 ShellRoute يحتوي الـ MainView + BottomNavBar
//       ShellRoute(
//         builder: (context, state, child) {
//           return MainView(child: child);
//         },
//         routes: [
//           GoRoute(
//             path: Routes.homeView,
//             builder: (context, state) => const HomeView(),
//             routes: [
//               GoRoute(
//                 path: Routes.showAllView,
//                 builder: (context, state) {
//                   return const ShowAllView();
//                 },
//               ),
//             ],
//           ),
//           GoRoute(
//             path: Routes.searchView,
//             builder: (context, state) => const SearchView(),
//           ),
//           GoRoute(
//             path: Routes.cartView,
//             builder: (context, state) {
//               return const CartView();
//             },
//             routes: [
//               GoRoute(
//                 path: Routes.checkoutView,
//                 builder: (context, state) {
//                   final providers = state.extra as Map<String, dynamic>;
//                   final bloc = providers['cart_bloc'] as CartBloc;
//                   final cubit = providers['get_cart_cubit'] as GetCartCubit;
//                   return CheckoutView(cartBloc: bloc, getCartCubit: cubit);
//                 },
//               ),
//             ],
//           ),
//           GoRoute(
//             path: Routes.profileView,
//             builder: (context, state) => const ProfileView(),
//             routes: [
//               GoRoute(
//                 path: Routes.editProfileView,
//                 pageBuilder: (context, state) {
//                   final userInfoCubit = state.extra as UserInfoCubit;
//                   return CustomTransitionPage(
//                     child: EditProfileView(userInfoCubit: userInfoCubit),
//                     transitionDuration: const Duration(milliseconds: 400),
//                     key: state.pageKey,
//                     transitionsBuilder:
//                         (context, animation, secondAnimation, child) {
//                           return FadeTransition(
//                             opacity: CurveTween(
//                               curve: Curves.easeInOutCirc,
//                             ).animate(animation),
//                             child: child,
//                           );
//                         },
//                   );
//                 },
//               ),
//               GoRoute(
//                 path: Routes.orderHistoryView,
//                 builder: (context, state) => const OrderHistoryView(),
//               ),
//               GoRoute(
//                 path: Routes.settingsView,
//                 builder: (context, state) => const SettingsView(),
//               ),
//               GoRoute(
//                 path: Routes.aboutUsView,
//                 builder: (context, state) => const AboutUsView(),
//               ),
//               GoRoute(
//                 path: Routes.shippingAddressView,
//                 builder: (context, state) => const ShippingAddressView(),
//               ),
//               GoRoute(
//                 path: Routes.favoriteView,
//                 builder: (context, state) => const FavouriteView(),
//               ),
//             ],
//           ),
//         ],
//       ),
//       GoRoute(
//         path: Routes.productDetailsView,
//         builder: (context, state) {
//           final productId = state.extra as int;
//           debugPrint('id from go router = $productId');
//           return ProductDetailsView(productId: productId);
//         },
//       ),
//     ],
//   );
// }
