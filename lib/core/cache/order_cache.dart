import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:hive/hive.dart';

import '../../features/07_cart_view/data/model/cart_model.dart';
import '../../features/07_cart_view/data/model/delivery_method_model.dart';
import '../../features/07_cart_view/data/model/location_model.dart';
import '../../features/07_cart_view/data/model/order_model.dart';
import '../errors/catch_error_handle.dart';
import '../helper/adapter_identifiers.dart';

abstract class OrderCache {
  Future<void> init();

  Future<Either<Failure, void>> addOrder({required OrderModel orderModel});

  Future<Either<Failure, OrderModel>> updateOrder({
    required String orderId,
    DeliveryMethodModel? deliverMethodModel,
    LocationModel? locationModel,
    DateTime? updateTime,
    List<CartModel>? carts,
    double? totalPrice,
    OrderStateEnum? orderState,
  });

  Future<Either<Failure, List<OrderModel>>> getOrderList();

  Future<Either<Failure, OrderModel>> getOrderState({
    required OrderModel orderModel,
  });

  Future<Either<Failure, void>> deleteAllOrders();

  Future<Either<Failure, void>> deleteOrder({required OrderModel orderModel});

  Future<Either<Failure, void>> deleteMultipleOrderItem({
    required List<OrderModel> orderList,
  });

  Future<Either<Failure, void>> saveUserLocation({
    required LocationModel locationModel,
  });

  Future<Either<Failure, LocationModel?>> getUserLocation();
}

class OrderCacheImplement implements OrderCache {
  late Box<OrderModel> _hiveBoxOrderModel;
  late Box<LocationModel> _hiveBoxLocationModel;
  final String userId;

  OrderCacheImplement({required this.userId});

  @override
  Future<void> init() async {
    //register all model adaptors
    OrderCacheAdaptorsClass.registerAllAdaptors();
    //open hiveBoxProductModel
    final orderBoxName = 'OrderBox$userId';
    final locationBoxName = 'LocationBox$userId';
    _hiveBoxOrderModel = Hive.isBoxOpen(orderBoxName)
        ? Hive.box<OrderModel>(orderBoxName)
        : await Hive.openBox<OrderModel>(orderBoxName);
    _hiveBoxLocationModel = Hive.isBoxOpen(locationBoxName)
        ? Hive.box<LocationModel>(locationBoxName)
        : await Hive.openBox<LocationModel>(locationBoxName);
  }

  @override
  Future<Either<Failure, void>> addOrder({
    required OrderModel orderModel,
  }) async {
    try {
      if (_hiveBoxOrderModel.get(orderModel.orderId) == null) {
        await Hive.box<OrderModel>('OrderBox$userId').clear();
        final orderModelIndependent = OrderModel.fromJson(orderModel.toJson());
        await _hiveBoxOrderModel.put(
          orderModelIndependent.orderId,
          orderModelIndependent,
        );
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrderList() async {
    try {
      List<OrderModel> cartList = _hiveBoxOrderModel.values.map((order) {
        return order.copyWith();
      }).toList();

      // ترتيب الأوردارات حسب وقت الإضافة (الأحدث أولاً)
      cartList.sort((a, b) => b.checkoutDateAt.compareTo(a.checkoutDateAt));

      return right(cartList);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllOrders() async {
    try {
      await _hiveBoxOrderModel.clear();
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder({
    required OrderModel orderModel,
  }) async {
    try {
      if (_hiveBoxOrderModel.get(orderModel.orderId) != null) {
        final productModelIndependent = OrderModel.fromJson(
          orderModel.toJson(),
        );
        await _hiveBoxOrderModel.delete(productModelIndependent.orderId);
        return right(null);
      } else {
        return left(CatchErrorHandle.catchBack(failure: 'order not found'));
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> updateOrder({
    required String orderId,
    DeliveryMethodModel? deliverMethodModel,
    LocationModel? locationModel,
    DateTime? updateTime,
    List<CartModel>? carts,
    double? totalPrice,
    OrderStateEnum? orderState,
  }) async {
    try {
      final existingModel = _hiveBoxOrderModel.get(orderId);
      if (existingModel != null) {
        final orderModelIndependent = OrderModel.fromJson(
          existingModel.toJson(),
        );

        final updateOrderModel = orderModelIndependent.copyWith(
          newCartList: carts,
          newCheckoutDateAt: updateTime,
          newDeliveryMethodModel: deliverMethodModel,
          newLocationModel: locationModel,
          newTotalPrice: totalPrice,
          newOrderStateEnum: orderState,
        );
        await _hiveBoxOrderModel.put(orderId, updateOrderModel);

        //get order list after update

        return right(updateOrderModel);
      } else {
        return left(CatchErrorHandle.catchBack(failure: 'order not found'));
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserLocation({
    required LocationModel locationModel,
  }) async {
    try {
      final locationModelIndependent = LocationModel.fromJson(
        locationModel.toJson(),
      );
      debugPrint('location of user = $locationModelIndependent');
      await _hiveBoxLocationModel.put(userId, locationModelIndependent);
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, LocationModel?>> getUserLocation() async {
    try {
      final locationData = _hiveBoxLocationModel.get(userId);

      if (locationData != null) {
        final LocationModel locationModel = LocationModel.fromJson(
          locationData.toJson(),
        );
        return right(locationModel);
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderState({
    required OrderModel orderModel,
  }) async {
    try {
      final now = DateTime.now();
      final difference = now.difference(orderModel.checkoutDateAt);
      final hours = difference.inHours;
      final days = difference.inDays;

      final independentModel = OrderModel.fromJson(orderModel.toJson());
      final deliveryMethod = orderModel.deliveryMethodModel;

      switch (deliveryMethod.deliveryType) {
        case DeliveryType.nextDay:
          if (hours < 12) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.pending,
              ),
            );
          } else if (hours < 24) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.transmit,
              ),
            );
          } else {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.delivered,
              ),
            );
          }

        case DeliveryType.standard:
          if (days < 2) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.pending,
              ),
            );
          } else if (days < 4) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.transmit,
              ),
            );
          } else if (days <= 5) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.delivered,
              ),
            );
          } else {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.cancel,
              ),
            );
          }

        case DeliveryType.nominated:
          final selectedDate =
              deliveryMethod.selectedTime ?? orderModel.checkoutDateAt;

          if (now.isBefore(selectedDate)) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.pending,
              ),
            );
          } else if (now.isAtSameMomentAs(selectedDate)) {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.transmit,
              ),
            );
          } else {
            return right(
              independentModel.copyWith(
                newOrderStateEnum: OrderStateEnum.delivered,
              ),
            );
          }
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMultipleOrderItem({
    required List<OrderModel> orderList,
  }) async {
    try {
      for (var order in orderList) {
        if (_hiveBoxOrderModel.containsKey(order.orderId)) {
          await _hiveBoxOrderModel.delete(order.orderId);
        }
      }
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}

class OrderCacheAdaptorsClass {
  static void registerAllAdaptors() {
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.orderModelAdapter)) {
      Hive.registerAdapter(OrderModelAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.deliveryTypeAdapter)) {
      Hive.registerAdapter(DeliveryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(
      AdaptorsIdentifiers.deliveryMethodModelAdapter,
    )) {
      Hive.registerAdapter(DeliveryMethodModelAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.locationModelAdapter)) {
      Hive.registerAdapter(LocationModelAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.orderStateEnumAdapter)) {
      Hive.registerAdapter(OrderStateEnumAdapter());
    }
  }
}
