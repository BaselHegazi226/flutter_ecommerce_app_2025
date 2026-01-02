import 'package:dartz/dartz.dart';

import '../../../../../core/cache/cart_cache.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/product_services.dart';
import '../../../domain/cart_repo/cart_repo.dart';
import '../../model/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartCache cartCache;
  final ProductServices productServices;

  CartRepositoryImpl({required this.cartCache, required this.productServices});

  @override
  Future<Either<Failure, GetCartResult>> getCart() async {
    final localResult = await cartCache.getCartList();

    return localResult.fold(
      (_) async {
        /// fallback to firebase
        final remoteResult = await productServices
            .getCartListAndTotalFromFirebase();

        return remoteResult.fold((failure) => left(failure), (data) async {
          if (data == null) {
            return right(GetCartResult(carts: [], totalPrice: 0));
          }

          await cartCache.addAllCartListAndTotalPrice(
            allCartListAsMap: data['cartList'],
            totalPrice: data['totalPrice'],
          );

          return right(
            GetCartResult(
              carts: (data['cartList'] as List)
                  .map((e) => CartModel.fromJson(e))
                  .toList(),
              totalPrice: data['totalPrice'],
            ),
          );
        });
      },
      (cartListSuccess) async {
        await cartCache.setCartTotalPrice(cartList: cartListSuccess);
        final total = await cartCache.getCartTotalPrice();

        return total.fold(
          (failure) => left(failure),
          (price) =>
              right(GetCartResult(carts: cartListSuccess, totalPrice: price)),
        );
      },
    );
  }

  @override
  Future<Either<Failure, AddToCartResult>> addToCart(CartModel model) async {
    final result = await cartCache.addProductCart(cartModel: model);

    return result.fold((failure) => left(failure), (dataSuccess) async {
      final carts = dataSuccess['cartList'] as List<CartModel>;
      final total = dataSuccess['totalPrice'] as double;
      final status = dataSuccess['AddOrDone'] as AddToCartEnum;

      if (status == AddToCartEnum.added) {
        await productServices.addCartToFireBase(
          cartModelList: carts,
          totalPrice: total,
        );
      }

      return right(
        AddToCartResult(carts: carts, totalPrice: total, status: status),
      );
    });
  }

  @override
  Future<Either<Failure, GetCartResult>> updateProductCount(
    int productId,
    int newCount,
  ) async {
    final result = await cartCache.updateProductCount(
      productId: productId,
      newCount: newCount,
    );

    return result.fold((failure) => left(failure), (data) async {
      final carts = data['cartList'] as List<CartModel>;
      final total = data['totalPrice'] as double;

      await productServices.updateCartInFireBase(
        newCartModelList: carts,
        newTotalPrice: total,
      );

      return right(GetCartResult(carts: carts, totalPrice: total));
    });
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    final result = await cartCache.removeAllProductCart();

    return result.fold((failure) => left(failure), (_) async {
      await productServices.deleteCartFromFireBase();
      return right(null);
    });
  }

  @override
  Future<Either<Failure, void>> clearProductCartById({required int id}) async {
    final result = await cartCache.removeProductCart(id: id);

    return result.fold(
      (error) {
        return left(error);
      },
      (successData) async {
        final List<CartModel> cartList =
            (successData['cartList'] as List<CartModel>);
        final double totalPrice = (successData['totalPrice'] as double);
        await productServices.updateCartInFireBase(
          newCartModelList: cartList,
          newTotalPrice: totalPrice,
        );
        return right(null);
      },
    );
  }
}
