import 'package:go_router/go_router.dart';

import '../../features/00_splash_view/presentation/view/splash_view.dart';
import '../../features/01_language_view/language_view.dart';
import '../../features/02_onboarding_view/presentation/view/onboarding_page_view.dart';
import '../../features/03_auth_view/presentation/view/login_view.dart';
import '../../features/03_auth_view/presentation/view/register_view.dart';
import '../../features/04_main_view/main_view.dart';
import '../../features/05_home_view/presentation/view/home_view.dart';
import '../../features/05_home_view/presentation/view/product_details_view.dart';
import '../../features/05_home_view/presentation/view/show_all_view.dart';
import '../../features/06_search_view/presentation/view/search_view.dart';
import '../../features/07_cart_view/presentation/view/cart_view.dart';
import '../../features/07_cart_view/presentation/view/checkout_view.dart';
import '../../features/07_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import '../../features/07_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import '../../features/08_profile_view/presentation/view/about_us_view.dart';
import '../../features/08_profile_view/presentation/view/edit_profile_view.dart';
import '../../features/08_profile_view/presentation/view/favourite_view.dart';
import '../../features/08_profile_view/presentation/view/order_history_view.dart';
import '../../features/08_profile_view/presentation/view/profile_view.dart';
import '../../features/08_profile_view/presentation/view/settings_view.dart';
import '../../features/08_profile_view/presentation/view/shipping_address_view.dart';
import '../../features/08_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
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

      //onboarding View
      GoRoute(
        path: Routes.onBoardingView,
        pageBuilder: (context, state) => AppTransitions.fade(
          key: state.pageKey,
          child: const OnboardingPageView(),
        ),
      ),

      GoRoute(
        path: Routes.languageView,
        pageBuilder: (context, state) => AppTransitions.fade(
          key: state.pageKey,
          child: const LanguageView(),
        ),
      ),

      /// Main Shell
      ShellRoute(
        builder: (context, state, child) => MainView(child: child),
        routes: [
          /// Home
          GoRoute(
            path: Routes.homeView,
            builder: (context, state) => const HomeView(),
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
            builder: (context, state) => const SearchView(),
          ),

          /// Cart
          GoRoute(
            path: Routes.cartView,
            builder: (context, state) => const CartView(),
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
            builder: (context, state) => const ProfileView(),
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
