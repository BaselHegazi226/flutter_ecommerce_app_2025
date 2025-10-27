import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';

import '../../../../../core/cache/cart_cache.dart';
import '../../../../../core/cache/favourite_cache.dart';
import '../../../../../core/cache/user_info_cache.dart';
import '../../../../../core/utilities/app_get.dart';

Future<void> initMethods({required String userId}) async {
  // ← الخطوة الجديدة والمهمة
  await UserInfoCache().init();
  //cart cache implement

  final AppGet appGet = AppGet();
  final getIt = appGet.getIt;
  //if user sign up in one phone more than time
  // i should unregister the singleton
  if (getIt.isRegistered<CartCacheImplement>()) {
    getIt.unregister<CartCacheImplement>();
  }
  if (getIt.isRegistered<FavouriteCacheImplement>()) {
    getIt.unregister<FavouriteCacheImplement>();
  }
  if (getIt.isRegistered<OrderCacheImplement>()) {
    getIt.unregister<OrderCacheImplement>();
  }
  if (getIt.isRegistered<ProductCubit>()) {
    getIt.unregister<ProductCubit>();
  }
  if (getIt.isRegistered<CartBloc>()) {
    getIt.unregister<CartBloc>();
  }
  if (getIt.isRegistered<GetCartCubit>()) {
    getIt.unregister<GetCartCubit>();
  }
  if (getIt.isRegistered<CategoryCubit>()) {
    getIt.unregister<CategoryCubit>();
  }
  //cart cache implement
  final cartCacheImplement = CartCacheImplement(userId: userId);
  await cartCacheImplement.init();

  //favourite cache implement
  final favouriteCacheImplement = FavouriteCacheImplement(userId: userId);
  await favouriteCacheImplement.init();
  //order cache implement
  final orderCacheImplement = OrderCacheImplement(userId: userId);
  await orderCacheImplement.init();

  AppGet().setUp(
    cartCacheImplement: cartCacheImplement,
    favouriteCacheImplement: favouriteCacheImplement,
    orderCacheImplement: orderCacheImplement,
  );
}
