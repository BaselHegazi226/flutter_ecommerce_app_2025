// import 'package:bloc/bloc.dart';
// import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
// import 'package:flutter_e_commerce_app_2025/core/services/product_services.dart';
// import 'package:meta/meta.dart';
//
// import '../../../data/model/cart_model.dart';
// import 'cart_state.dart';
//
// part 'cart_event.dart';
//
// class CartBloc extends Bloc<CartEvent, CartState> {
//   final CartCache cartCache;
//   final ProductServices productServices;
//
//   CartBloc({required this.cartCache, required this.productServices})
//     : super(CartInitial()) {
//     on<AddToCartEvent>(_onEventAddProductCart);
//     on<UpdateProductCountEvent>(_onEventUpdateProductCountCart);
//
//     on<DeleteAllProductsEvent>(_onDeleteAllProductsCart);
//     on<DeleteProductEvent>(_onDeleteProductByCartModel);
//   }
//
//   Future<void> _onEventAddProductCart(
//     AddToCartEvent event,
//     Emitter<CartState> emit,
//   ) async {
//     emit(AddToCartLoading());
//     var result = await cartCache.addProductCart(cartModel: event.cartModel);
//
//     result.fold(
//       (error) {
//         emit(AddToCartFailure(errorMessage: error.errorKey ?? 'unknown error'));
//       },
//       (success) async {
//         if (success['AddOrDone'] == AddToCartEnum.added) {
//           var result2 = await productServices.addCartToFireBase(
//             cartModelList: success['cartList'],
//             totalPrice: success['totalPrice'],
//           );
//           result2.fold(
//             (error) {
//               emit(
//                 AddToCartFailure(
//                   errorMessage: error.errorKey ?? 'unknown error',
//                 ),
//               );
//             },
//             (success) {
//               emit(AddToCartSuccess());
//             },
//           );
//         } else {
//           emit(AddToCartDone());
//         }
//       },
//     );
//   }
//
//   Future<void> _onEventUpdateProductCountCart(
//     UpdateProductCountEvent event,
//     Emitter<CartState> emit,
//   ) async {
//     emit(UpdateProductCountLoading());
//     var result = await cartCache.updateProductCount(
//       productId: event.productId,
//       newCount: event.newCount,
//     );
//     result.fold(
//       (error) {
//         emit(
//           UpdateProductCountFailure(
//             errorMessage: error.errorKey ?? 'unknown error',
//           ),
//         );
//       },
//       (success) async {
//         var result2 = await productServices.updateCartInFireBase(
//           newCartModelList: success['cartList'],
//           newTotalPrice: success['totalPrice'],
//         );
//         result2.fold(
//           (error) {
//             emit(
//               UpdateProductCountFailureOnline(
//                 errorMessage: error.errorKey ?? 'unknown',
//               ),
//             );
//           },
//           (success) {
//             emit(UpdateProductCountSuccess());
//           },
//         );
//       },
//     );
//   }
//
//   Future<void> _onDeleteAllProductsCart(
//     DeleteAllProductsEvent event,
//     Emitter<CartState> emit,
//   ) async {
//     emit(DeleteAllProductLoading());
//     var result = await cartCache.removeAllProductCart();
//     result.fold(
//       (error) {
//         emit(
//           DeleteAllProductFailure(
//             errorMessage: error.errorKey ?? 'unknown error',
//           ),
//         );
//       },
//       (success) {
//         emit(DeleteAllProductSuccess());
//       },
//     );
//   }
//
//   Future<void> _onDeleteProductByCartModel(
//     DeleteProductEvent event,
//     Emitter<CartState> emit,
//   ) async {
//     emit(DeleteProductLoading());
//     var result = await cartCache.removeProductCart(id: event.id);
//     result.fold(
//       (error) {
//         emit(
//           DeleteProductFailure(errorMessage: error.errorKey ?? 'unknown error'),
//         );
//       },
//       (success) async {
//         var result = await productServices.updateCartInFireBase(
//           newCartModelList: success['cartList'],
//           newTotalPrice: success['totalPrice'],
//         );
//         result.fold(
//           (error) {
//             emit(
//               DeleteAllProductFailure(
//                 errorMessage: error.errorKey ?? 'unknown error',
//               ),
//             );
//           },
//           (success) {
//             emit(DeleteProductSuccess());
//           },
//         );
//       },
//     );
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/cache/cart_cache.dart';
import '../../../data/model/cart_model.dart';
import '../../../domain/use_cases/cart_use_cases.dart';
import 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final UpdateProductCountUseCase updateProductCountUseCase;
  final ClearCartUseCase clearProductUseCase;
  final RemoveProductCartById removeProductCartById;

  CartBloc({
    required this.addToCartUseCase,
    required this.updateProductCountUseCase,
    required this.clearProductUseCase,
    required this.removeProductCartById,
  }) : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateProductCountEvent>(_onUpdateProductCount);
    on<DeleteAllProductsEvent>(_onDeleteAllProduct);
    on<DeleteProductEvent>(_onDeleteProductCartById);
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(AddToCartLoading());

    final result = await addToCartUseCase(event.cartModel);

    result.fold(
      (failure) {
        emit(
          AddToCartFailure(errorMessage: failure.errorKey ?? 'unknown error'),
        );
      },
      (data) {
        if (data.status == AddToCartEnum.added) {
          emit(AddToCartSuccess());
        } else {
          emit(AddToCartDone());
        }
      },
    );
  }

  Future<void> _onUpdateProductCount(
    UpdateProductCountEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(UpdateProductCountLoading());

    final result = await updateProductCountUseCase(
      event.productId,
      event.newCount,
    );

    result.fold(
      (failure) {
        emit(
          UpdateProductCountFailure(
            errorMessage: failure.errorKey ?? 'unknown error',
          ),
        );
      },
      (_) {
        emit(UpdateProductCountSuccess());
      },
    );
  }

  Future<void> _onDeleteAllProduct(
    DeleteAllProductsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(DeleteAllProductLoading());

    final result = await clearProductUseCase();

    result.fold(
      (failure) {
        emit(
          DeleteAllProductFailure(
            errorMessage: failure.errorKey ?? 'unknown error',
          ),
        );
      },
      (_) {
        emit(DeleteAllProductSuccess());
      },
    );
  }

  Future<void> _onDeleteProductCartById(
    DeleteProductEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(DeleteProductLoading());
    final result = await removeProductCartById(event.id);
    result.fold(
      (error) {
        emit(
          DeleteProductFailure(errorMessage: error.errorKey ?? 'unknown error'),
        );
      },
      (successData) {
        emit(DeleteProductSuccess());
      },
    );
  }
}
