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
    LocationModel? locationModel,
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
      locationModel: locationModel,
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

  Future<void> saveUserLocation({required LocationModel locationModel}) async {
    emit(SaveUserLocationLoading());
    final result = await orderCache.saveUserLocation(
      locationModel: locationModel,
    );
    result.fold(
      (error) {
        emit(
          SaveUserLocationFailure(errorMessage: error.errorKey ?? 'unknown'),
        );
      },
      (success) {
        emit(SaveUserLocationSuccess());
      },
    );
  }

  Future<void> getUserLocation() async {
    emit(GetUserLocationLoading());
    final result = await orderCache.getUserLocation();
    result.fold(
      (error) {
        emit(GetUserLocationFailure(errorMessage: error.errorKey ?? 'unknown'));
      },
      (success) {
        if (success != null) {
          emit(GetUserLocationSuccess(locationModel: success));
        } else {
          emit(GetUserLocationFailure(errorMessage: 'Not Found User Location'));
        }
      },
    );
  }
}
