import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/delivery_method_model.dart';
import '../../../data/model/location_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderCache orderCache;
  OrderCubit({required this.orderCache}) : super(OrderInitial());

  Future<void> addOrder({required OrderModel orderModel}) async {
    emit(AddOrderLoading());
    final result = await orderCache.addOrder(orderModel: orderModel);
    result.fold(
      (error) {
        emit(
          AddOrderFailure(errorMessage: error.errorMessage ?? 'unknown error'),
        );
      },
      (success) {
        emit(AddOrderSuccess());
      },
    );
  }

  Future<void> deleteOrder({required OrderModel orderModel}) async {
    emit(DeleteOrderInitial());
    final result = await orderCache.deleteOrder(orderModel: orderModel);
    result.fold(
      (error) {
        emit(
          DeleteOrderFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
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
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(DeleteAllOrdersSuccess());
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
          UpdateOrderFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (orderUpdated) {
        emit(UpdateOrderSuccess(order: orderUpdated));
      },
    );
  }

  Future<void> getOrderList() async {
    emit(GetOrderListLoading());
    final result = await orderCache.getOrderList();
    result.fold(
      (error) {
        emit(
          GetOrderListFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (successOrders) async {
        List<OrderModel> updatedOrders = [];

        for (var item in successOrders) {
          final orderAfterGetState = await orderCache.getOrderState(
            orderModel: item,
          );

          orderAfterGetState.fold(
            (error) {
              // هنا الأفضل تحتفظ بالأوردر الأصلي لو فشل التحديث
              updatedOrders.add(item);
            },
            (success) {
              updatedOrders.add(success);
            },
          );
        }

        // بعد ما تخلص كله، اعرض النتيجة النهائية مرة واحدة
        emit(GetOrderListSuccess(orders: updatedOrders));
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
          SaveUserLocationFailure(
            errorMessage: error.errorMessage ?? 'unknown',
          ),
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
        emit(
          GetUserLocationFailure(errorMessage: error.errorMessage ?? 'unknown'),
        );
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

  Future<void> deleteMultipleOrders({required List<OrderModel> orders}) async {
    emit(DeleteMultipleOrdersInitial());
    final result = await orderCache.deleteMultipleOrderItem(orderList: orders);
    result.fold(
      (error) {
        emit(
          DeleteMultipleOrdersFailure(
            errorMessage: error.errorMessage ?? 'unknown',
          ),
        );
      },
      (success) {
        emit(DeleteMultipleOrdersSuccess());
      },
    );
  }
}
