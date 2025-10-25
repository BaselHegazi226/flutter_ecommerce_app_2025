import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/adapter_identifiers.dart';
import 'package:hive/hive.dart';

import '../../features/05_cart_view/data/model/cart_model.dart';

abstract class CartCache {
  Future<void> init();
  Future<Either<Failure, AddToCartEnum>> addProductCart({
    required CartModel cartModel,
  });
  Future<Either<Failure, List<CartModel>>> updateProductCount({
    required int productId,
    required int newCount,
  });
  Future<Either<Failure, List<CartModel>>> getCartList();
  Future<Either<Failure, void>> setCartTotalPrice({
    required List<CartModel> cartList,
  });
  Future<Either<Failure, double>> getCartTotalPrice();
  Future<Either<Failure, void>> removeAllProductCart();
  Future<Either<Failure, void>> removeProductCart({
    required CartModel cartModel,
  });
}

class CartCacheImplement implements CartCache {
  final String userId;
  late Box<CartModel> hiveBoxProductModel;
  late double _totalPrice;

  CartCacheImplement({required this.userId});
  @override
  Future<void> init() async {
    //register all model adaptors
    CartCacheAdaptorsClass.registerAdaptors();
    //open hiveBoxProductModel
    final boxName = 'CartBox$userId';
    hiveBoxProductModel = Hive.isBoxOpen(boxName)
        ? Hive.box<CartModel>(boxName)
        : await Hive.openBox<CartModel>(boxName);

    //give init value with 0 to total price
    _totalPrice = 0;
  }

  @override
  Future<Either<Failure, AddToCartEnum>> addProductCart({
    required CartModel cartModel,
  }) async {
    try {
      if (hiveBoxProductModel.get(cartModel.id) == null) {
        final cartModelIndependent = CartModel.fromJson(cartModel.toJson());
        final newCartModel = cartModel.copyWith(
          newId: cartModelIndependent.id,
          newImageUrl: cartModelIndependent.imageUrl,
          newPrice: cartModelIndependent.price,
          newTitle: cartModelIndependent.title,
        );
        await hiveBoxProductModel.put(newCartModel.id, newCartModel);
        return right(AddToCartEnum.added);
      } else {
        return right(AddToCartEnum.isAddedAlready);
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> updateProductCount({
    required int productId,
    required int newCount,
  }) async {
    try {
      final existingModel = hiveBoxProductModel.get(productId);
      if (existingModel != null) {
        final cartModelIndependent = CartModel.fromJson(existingModel.toJson());

        final updateCartModel = cartModelIndependent.copyWith(
          newCount: newCount,
        );
        await hiveBoxProductModel.put(productId, updateCartModel);

        //get cart list after update
        List<CartModel> cartList = hiveBoxProductModel.values.map((cart) {
          final independentCartProduct = CartModel.fromJson(cart.toJson());
          return cart.copyWith(newCount: independentCartProduct.productCount);
        }).toList();

        return right(cartList);
      } else {
        return left(CatchErrorHandle.catchBack(failure: 'product not found'));
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartList() async {
    try {
      debugPrint('CartCache opened for userId = $userId');

      List<CartModel> cartList = hiveBoxProductModel.values.map((cart) {
        return cart.copyWith();
      }).toList();

      // ترتيب السلة حسب وقت الإضافة (الأحدث أولاً)
      cartList.sort((a, b) => b.addAt.compareTo(a.addAt));

      return right(cartList);
    } catch (e) {
      debugPrint('error from get = $e');
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> removeAllProductCart() async {
    try {
      await hiveBoxProductModel.clear();
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> removeProductCart({
    required CartModel cartModel,
  }) async {
    try {
      if (hiveBoxProductModel.get(cartModel.id) != null) {
        await hiveBoxProductModel.delete(cartModel.id);
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, double>> getCartTotalPrice() async {
    try {
      return right(_totalPrice);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> setCartTotalPrice({
    required List<CartModel> cartList,
  }) async {
    try {
      _totalPrice = 0;
      cartList.map((item) {
        _totalPrice += item.productCount * item.price;
      }).toList();
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}

class CartCacheAdaptorsClass {
  static void registerAdaptors() {
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.cartModelAdapter)) {
      Hive.registerAdapter(CartModelAdapter());
    }
  }
}

enum AddToCartEnum { added, isAddedAlready }
