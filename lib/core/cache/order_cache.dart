import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/cart_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/delivery_method_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/location_model.dart';
import 'package:hive/hive.dart';

import '../../features/05_cart_view/data/model/order_model.dart';
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
    OrderState? orderState,
  });
  Future<Either<Failure, List<OrderModel>>> getOrderList();
  Future<Either<Failure, void>> removeAllOrders();
  Future<Either<Failure, void>> removeOrder({required OrderModel orderModel});
}

class OrderCacheImplement implements OrderCache {
  late Box<OrderModel> hiveBoxOrderModel;
  final String userId;
  OrderCacheImplement({required this.userId});
  @override
  Future<void> init() async {
    //register all model adaptors
    OrderCacheAdaptorsClass.registerAllAdaptors();
    //open hiveBoxProductModel
    final boxName = 'OrderBox$userId';
    hiveBoxOrderModel = Hive.isBoxOpen(boxName)
        ? Hive.box<OrderModel>(boxName)
        : await Hive.openBox<OrderModel>(boxName);
  }

  @override
  Future<Either<Failure, void>> addOrder({
    required OrderModel orderModel,
  }) async {
    try {
      if (hiveBoxOrderModel.get(orderModel.orderId) == null) {
        final productModelIndependent = OrderModel.fromJson(
          orderModel.toJson(),
        );
        await hiveBoxOrderModel.put(
          productModelIndependent.orderId,
          productModelIndependent,
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
      List<OrderModel> cartList = hiveBoxOrderModel.values.map((order) {
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
  Future<Either<Failure, void>> removeAllOrders() async {
    try {
      await hiveBoxOrderModel.clear();
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, void>> removeOrder({
    required OrderModel orderModel,
  }) async {
    try {
      if (hiveBoxOrderModel.get(orderModel.orderId) != null) {
        final productModelIndependent = OrderModel.fromJson(
          orderModel.toJson(),
        );
        await hiveBoxOrderModel.delete(productModelIndependent.orderId);
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
    OrderState? orderState,
  }) async {
    try {
      final existingModel = hiveBoxOrderModel.get(orderId);
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
          newOrderState: orderState,
        );
        await hiveBoxOrderModel.put(orderId, updateOrderModel);

        //get order list after update

        return right(updateOrderModel);
      } else {
        return left(CatchErrorHandle.catchBack(failure: 'order not found'));
      }
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
    if (!Hive.isAdapterRegistered(
      AdaptorsIdentifiers.deliveryMethodModelAdapter,
    )) {
      Hive.registerAdapter(DeliveryMethodModelAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.locationModelAdapter)) {
      Hive.registerAdapter(LocationModelAdapter());
    }
  }
}
