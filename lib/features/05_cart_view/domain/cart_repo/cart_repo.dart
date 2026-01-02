import 'package:dartz/dartz.dart';

import '../../../../core/cache/cart_cache.dart';
import '../../../../core/errors/failure.dart';
import '../../data/model/cart_model.dart';

abstract class CartRepository {
  Future<Either<Failure, GetCartResult>> getCart();

  Future<Either<Failure, AddToCartResult>> addToCart(CartModel model);

  Future<Either<Failure, GetCartResult>> updateProductCount(
    int productId,
    int newCount,
  );

  Future<Either<Failure, void>> clearCart();

  Future<Either<Failure, void>> clearProductCartById({required int id});
}

class GetCartResult {
  final List<CartModel> carts;
  final double totalPrice;

  GetCartResult({required this.carts, required this.totalPrice});
}

class AddToCartResult extends GetCartResult {
  final AddToCartEnum status;

  AddToCartResult({
    required super.carts,
    required super.totalPrice,
    required this.status,
  });
}
