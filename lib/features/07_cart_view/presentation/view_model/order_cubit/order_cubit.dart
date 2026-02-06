import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';

import '../../../../07_cart_view/data/model/cart_model.dart';
import '../../../../07_cart_view/data/model/delivery_method_model.dart';
import '../../../../07_cart_view/data/model/location_model.dart';
import '../../../../07_cart_view/data/model/order_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderCache orderCache;

  OrderCubit({required this.orderCache}) : super(OrderInitial());

  Future<void> addOrder({required OrderModel orderModel}) async {
    emit(AddOrderLoading());
    final result = await orderCache.addOrder(orderModel: orderModel);
    result.fold(
      (error) {
        emit(AddOrderFailure(errorMessage: error.errorKey ?? 'unknown error'));
      },
      (success) {
        emit(AddOrderSuccess());
      },
    );
  }

  Future<void> updateOrder({
    required String orderId,
    DeliveryMethodModel? deliverMethodModel,
    OrderInfoModel? orderInfoModel,
    DateTime? updateTime,
    List<CartModel>? carts,
    double? totalPrice,
    OrderStateEnum? orderState,
  }) async {
    emit(UpdateOrderLoading());
    final result = await orderCache.updateOrder(
      orderId: orderId,
      totalPrice: totalPrice,
      deliverMethodModel: deliverMethodModel,
      orderInfoModel: orderInfoModel,
      updateTime: updateTime,
      orderState: orderState,
    );
    result.fold(
      (error) {
        emit(
          UpdateOrderFailure(errorMessage: error.errorKey ?? 'unknown error'),
        );
      },
      (orderUpdated) {
        emit(UpdateOrderSuccess(order: orderUpdated));
      },
    );
  }

  Future<void> saveUserInfo({required OrderInfoModel orderInfoModel}) async {
    emit(SaveOrderInfoLoading());
    final result = await orderCache.saveOrderInfo(
      orderInfoModel: orderInfoModel,
    );
    result.fold(
      (error) {
        emit(SaveOrderInfoFailure(errorMessage: error.errorKey ?? 'unknown'));
      },
      (success) {
        emit(SaveOrderInfoSuccess());
      },
    );
  }

  Future<void> getOrderInfo() async {
    emit(GetOrderInfoLoading());
    final result = await orderCache.getOrderInfo();
    result.fold(
      (error) {
        emit(GetOrderInfoFailure(errorMessage: error.errorKey ?? 'unknown'));
      },
      (success) {
        if (success != null) {
          emit(GetOrderInfoSuccess(orderInfoModel: success));
        } else {
          emit(GetOrderInfoFailure(errorMessage: 'Not Found User Location'));
        }
      },
    );
  }
}
