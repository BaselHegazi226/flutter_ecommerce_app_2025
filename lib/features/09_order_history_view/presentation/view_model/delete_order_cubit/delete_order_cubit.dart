import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:meta/meta.dart';

import '../../../../07_cart_view/data/model/order_model.dart';

part 'delete_order_state.dart';

class DeleteOrderCubit extends Cubit<DeleteOrderState> {
  DeleteOrderCubit({required this.orderCache}) : super(DeleteOrderInitial());
  final OrderCache orderCache;

  Future<void> deleteOrder({required OrderModel orderModel}) async {
    emit(DeleteOrderInitial());
    final result = await orderCache.deleteOrder(orderModel: orderModel);
    result.fold(
      (error) {
        emit(
          DeleteOrderFailure(errorMessage: error.errorKey ?? 'unknown error'),
        );
      },
      (success) {
        emit(DeleteAllOrdersSuccess());
      },
    );
  }

  Future<void> deleteAllOrders() async {
    emit(DeleteAllOrdersLoading());
    final result = await orderCache.deleteAllOrders();
    result.fold(
      (error) {
        emit(
          DeleteAllOrdersFailure(
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(DeleteAllOrdersSuccess());
      },
    );
  }

  Future<void> deleteMultipleOrders({required List<OrderModel> orders}) async {
    emit(DeleteMultipleOrdersInitial());
    final result = await orderCache.deleteMultipleOrderItem(orderList: orders);
    result.fold(
      (error) {
        emit(
          DeleteMultipleOrdersFailure(
            errorMessage: error.errorKey ?? 'unknown',
          ),
        );
      },
      (success) {
        emit(DeleteMultipleOrdersSuccess());
      },
    );
  }
}
