import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/cart_use_cases.dart';
import 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final GetCartUseCase getCartUseCase;

  GetCartCubit({required this.getCartUseCase}) : super(GetCartInitial());

  Future<void> getCartProductsAndTotal() async {
    emit(GetProductCartAndTotalLoading());

    final result = await getCartUseCase();

    result.fold(
      (failure) {
        emit(
          GetProductCartAndTotalFailure(
            errorMessage: failure.errorKey ?? 'unknown error',
          ),
        );
      },
      (data) {
        emit(
          GetProductCartAndTotalSuccess(
            carts: data.carts,
            totalPrice: data.totalPrice,
          ),
        );
      },
    );
  }
}
