import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/cart_model.dart';
import 'package:meta/meta.dart';

import 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartCache cartCache;
  CartBloc({required this.cartCache}) : super(CartInitial()) {
    on<AddToCartEvent>(_onEventAddProductCart);
    on<UpdateProductCountEvent>(_onEventUpdateProductCountCart);

    on<DeleteAllProductsEvent>(_onDeleteAllProductsCart);
    on<DeleteProductEvent>(_onDeleteProductByCartModel);
  }
  Future<void> _onEventAddProductCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(AddToCartLoading());
    var result = await cartCache.addProductCart(cartModel: event.cartModel);
    result.fold(
      (error) {
        return emit(
          AddToCartFailure(errorMessage: error.errorMessage ?? 'unknown error'),
        );
      },
      (success) {
        if (success == AddToCartEnum.added) {
          return emit(AddToCartSuccess());
        } else {
          return emit(AddToCartDone());
        }
      },
    );
  }

  Future<void> _onEventUpdateProductCountCart(
    UpdateProductCountEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(UpdateProductCountLoading());
    var result = await cartCache.updateProductCount(
      productId: event.productId,
      newCount: event.newCount,
    );
    result.fold(
      (error) {
        return emit(
          UpdateProductCountFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        return emit(UpdateProductCountSuccess(updateCartList: success));
      },
    );
  }

  Future<void> _onDeleteAllProductsCart(
    DeleteAllProductsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(DeleteAllProductLoading());
    var result = await cartCache.removeAllProductCart();
    result.fold(
      (error) {
        return emit(
          DeleteAllProductFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        return emit(DeleteAllProductSuccess());
      },
    );
  }

  Future<void> _onDeleteProductByCartModel(
    DeleteProductEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(DeleteProductLoading());
    var result = await cartCache.removeProductCart(cartModel: event.cartModel);
    result.fold(
      (error) {
        return emit(
          DeleteProductFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        return emit(DeleteProductSuccess());
      },
    );
  }
}
