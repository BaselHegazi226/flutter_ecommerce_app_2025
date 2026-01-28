import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/favourite_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/user_info_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/services/product_services.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/data/repo_impl/profile_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/domain/use_cases/profile_use_cases.dart';
import 'package:get_it/get_it.dart';

import '../../features/05_home_view/data/repo/home_view_repo_impl.dart';
import '../../features/05_home_view/presentation/view_model/category_cubit/category_cubit.dart';
import '../../features/07_cart_view/data/repo_impl/cart_repo_impl/cart_repo_implemnt.dart';
import '../../features/07_cart_view/domain/cart_repo/cart_repo.dart';
import '../../features/07_cart_view/domain/use_cases/cart_use_cases.dart';
import '../../features/07_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import '../../features/07_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';

class AppGet {
  final GetIt getIt = GetIt.instance;

  void setUp({
    required CartCacheImplement cartCacheImplement,
    required ProductServices productServices,
    required FavouriteCacheImplement favouriteCacheImplement,
    required OrderCacheImplement orderCacheImplement,
    required UserInfoCache userInfoCache,
    required UserServices userServices,
  }) {
    /// ============================
    /// Core / Cache / Services
    /// ============================

    if (!getIt.isRegistered<CartCacheImplement>()) {
      getIt.registerSingleton<CartCacheImplement>(cartCacheImplement);
    }

    if (!getIt.isRegistered<ProductServices>()) {
      getIt.registerSingleton<ProductServices>(productServices);
    }

    if (!getIt.isRegistered<FavouriteCacheImplement>()) {
      getIt.registerSingleton<FavouriteCacheImplement>(favouriteCacheImplement);
    }

    if (!getIt.isRegistered<OrderCacheImplement>()) {
      getIt.registerSingleton<OrderCacheImplement>(orderCacheImplement);
    }

    /// ============================
    /// Repositories
    /// ============================

    if (!getIt.isRegistered<CartRepository>()) {
      getIt.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(
          cartCache: getIt<CartCacheImplement>(),
          productServices: getIt<ProductServices>(),
        ),
      );
    }

    if (!getIt.isRegistered<HomeViewRepoImpl>()) {
      getIt.registerLazySingleton<HomeViewRepoImpl>(() => HomeViewRepoImpl());
    }

    if (!getIt.isRegistered<ProfileRepoImpl>()) {
      getIt.registerLazySingleton<ProfileRepoImpl>(
        () => ProfileRepoImpl(
          userServices: userServices,
          userInfoCache: userInfoCache,
        ),
      );
    }

    /// ============================
    /// Cart UseCases
    /// ============================

    if (!getIt.isRegistered<AddToCartUseCase>()) {
      getIt.registerLazySingleton(
        () => AddToCartUseCase(getIt<CartRepository>()),
      );
    }

    if (!getIt.isRegistered<RemoveProductCartById>()) {
      getIt.registerLazySingleton(
        () => RemoveProductCartById(getIt<CartRepository>()),
      );
    }

    if (!getIt.isRegistered<ClearCartUseCase>()) {
      getIt.registerLazySingleton(
        () => ClearCartUseCase(getIt<CartRepository>()),
      );
    }

    if (!getIt.isRegistered<GetCartUseCase>()) {
      getIt.registerLazySingleton(
        () => GetCartUseCase(getIt<CartRepository>()),
      );
    }

    if (!getIt.isRegistered<UpdateProductCountUseCase>()) {
      getIt.registerLazySingleton(
        () => UpdateProductCountUseCase(getIt<CartRepository>()),
      );
    }

    if (!getIt.isRegistered<UploadImageToCloudniaryUseCase>()) {
      getIt.registerLazySingleton(
        () => UploadImageToCloudniaryUseCase(getIt<ProfileRepoImpl>()),
      );
    }
    if (!getIt.isRegistered<ChangeCurrentUserNameUseCase>()) {
      getIt.registerLazySingleton(
        () => ChangeCurrentUserNameUseCase(getIt<ProfileRepoImpl>()),
      );
    }

    if (!getIt.isRegistered<SignOutUseCase>()) {
      getIt.registerLazySingleton(
        () => SignOutUseCase(getIt<ProfileRepoImpl>()),
      );
    }
    if (!getIt.isRegistered<UpdateProfileUseCase>()) {
      getIt.registerLazySingleton(
        () => UpdateProfileUseCase(getIt<ProfileRepoImpl>()),
      );
    }

    /// ============================
    /// Blocs / Cubits
    /// ============================

    if (!getIt.isRegistered<CartBloc>()) {
      getIt.registerFactory<CartBloc>(
        () => CartBloc(
          addToCartUseCase: getIt(),
          updateProductCountUseCase: getIt(),
          clearProductUseCase: getIt(),
          removeProductCartById: getIt(),
        ),
      );
    }

    if (!getIt.isRegistered<GetCartCubit>()) {
      getIt.registerFactory<GetCartCubit>(
        () => GetCartCubit(getCartUseCase: getIt()),
      );
    }

    if (!getIt.isRegistered<CategoryCubit>()) {
      getIt.registerLazySingleton<CategoryCubit>(
        () => CategoryCubit(homeViewRepo: getIt<HomeViewRepoImpl>()),
      );
    }
  }
}
