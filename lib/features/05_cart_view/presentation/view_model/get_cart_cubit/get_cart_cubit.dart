import 'package:bloc/bloc.dart';

import '../../../../../core/cache/cart_cache.dart';
import 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final CartCache cartCache;
  GetCartCubit({required this.cartCache}) : super(GetCartInitial());

  Future<void> getCartProductsAndTotal() async {
    emit(GetProductCartAndTotalLoading());
    var result = await cartCache.getCartList();
    result.fold(
      (error) {
        emit(
          GetProductCartAndTotalFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (cartListSuccess) async {
        cartCache.setCartTotalPrice(cartList: cartListSuccess);
        final totalResult = await cartCache.getCartTotalPrice();
        totalResult.fold(
          (error) {
            emit(
              GetProductCartAndTotalFailure(
                errorMessage: error.errorMessage ?? 'unknown error',
              ),
            );
          },
          (totalPrice) {
            emit(
              GetProductCartAndTotalSuccess(
                carts: cartListSuccess,
                totalPrice: totalPrice,
              ),
            );
          },
        );
      },
    );
  }
}
