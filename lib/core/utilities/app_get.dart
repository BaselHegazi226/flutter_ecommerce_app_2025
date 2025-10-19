import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/favourite_cache.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:get_it/get_it.dart';

class AppGet {
  final getIt = GetIt.instance;
  void setUp({
    required CartCacheImplement cartCacheImplement,
    required FavouriteCacheImplement favouriteCacheImplement,
  }) {
    getIt.registerLazySingleton<HomeViewRepoImpl>(() => HomeViewRepoImpl());

    getIt.registerSingleton<CartCacheImplement>(cartCacheImplement);
    getIt.registerSingleton<FavouriteCacheImplement>(favouriteCacheImplement);

    getIt.registerLazySingleton<CategoryCubit>(
      () => CategoryCubit(homeViewRepo: getIt<HomeViewRepoImpl>()),
    );
    getIt.registerLazySingleton<ProductCubit>(
      () => ProductCubit(homeViewRepo: getIt<HomeViewRepoImpl>()),
    );

    getIt.registerLazySingleton<CartBloc>(
      () => CartBloc(cartCache: getIt<CartCacheImplement>()),
    );
    getIt.registerLazySingleton<GetCartCubit>(
      () => GetCartCubit(cartCache: getIt<CartCacheImplement>()),
    );
  }
}
