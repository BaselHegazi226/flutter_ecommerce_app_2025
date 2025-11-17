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
  await UserInfoCache().init();

  final getIt = AppGet().getIt;

  // مسح كل الكاشات القديمة عند تغيير المستخدم
  getIt.resetLazySingleton<CartCacheImplement>();
  getIt.resetLazySingleton<FavouriteCacheImplement>();
  getIt.resetLazySingleton<OrderCacheImplement>();
  getIt.resetLazySingleton<ProductCubit>();
  getIt.resetLazySingleton<CartBloc>();
  getIt.resetLazySingleton<GetCartCubit>();
  getIt.resetLazySingleton<CategoryCubit>();

  // إنشاء الكاش الجديد الخاص بالمستخدم
  final cartCacheImplement = CartCacheImplement(userId: userId);
  await cartCacheImplement.init();

  final favouriteCacheImplement = FavouriteCacheImplement(userId: userId);
  await favouriteCacheImplement.init();

  final orderCacheImplement = OrderCacheImplement(userId: userId);
  await orderCacheImplement.init();

  AppGet().setUp(
    cartCacheImplement: cartCacheImplement,
    favouriteCacheImplement: favouriteCacheImplement,
    orderCacheImplement: orderCacheImplement,
  );
}
