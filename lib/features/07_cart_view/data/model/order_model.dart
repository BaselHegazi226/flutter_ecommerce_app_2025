import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'cart_model.dart';
import 'delivery_method_model.dart';
import 'location_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 7)
class OrderModel {
  @HiveField(0)
  final String orderId;

  @HiveField(1)
  final List<CartModel> cartModelList;

  @HiveField(2)
  final DeliveryMethodModel deliveryMethodModel;

  @HiveField(3)
  final LocationModel locationModel;

  @HiveField(4)
  final double totalPrice;

  @HiveField(5)
  final DateTime checkoutDateAt;

  @HiveField(6)
  final OrderStateEnum orderStateEnum;

  OrderModel({
    required this.orderId,
    required this.cartModelList,
    required this.deliveryMethodModel,
    required this.locationModel,
    required this.totalPrice,
    required this.checkoutDateAt,
    required this.orderStateEnum,
  });

  factory OrderModel.fromJson(Map<String, dynamic> jsonData) {
    final addAtRaw = jsonData['checkoutDateAt'];

    DateTime parsedAddAt;
    if (addAtRaw is Timestamp) {
      parsedAddAt = addAtRaw.toDate();
    } else if (addAtRaw is DateTime) {
      parsedAddAt = addAtRaw;
    } else {
      parsedAddAt = DateTime.now(); // fallback
    }
    return OrderModel(
      orderId: jsonData['orderId'] ?? '',
      cartModelList: (jsonData['cartModel'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryMethodModel: DeliveryMethodModel.fromJson(
        jsonData['deliveryMethodModel'],
      ),
      locationModel: LocationModel.fromJson(jsonData['locationModel']),
      totalPrice: (jsonData['totalPrice'] as num).toDouble(),
      checkoutDateAt: parsedAddAt,
      orderStateEnum: OrderStateEnum.values.firstWhere(
        (e) => e.name == jsonData['orderStateEnum'],
        orElse: () => OrderStateEnum.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'cartModel': cartModelList.map((e) => e.toJson()).toList(),
      'deliveryMethodModel': deliveryMethodModel.toJson(),
      'locationModel': locationModel.toJson(),
      'totalPrice': totalPrice,
      'checkoutDateAt': checkoutDateAt.toIso8601String(),
      'orderStateEnum': orderStateEnum.name,
    };
  }

  OrderModel copyWith({
    List<CartModel>? newCartList,
    DeliveryMethodModel? newDeliveryMethodModel,
    LocationModel? newLocationModel,
    double? newTotalPrice,
    DateTime? newCheckoutDateAt,
    OrderStateEnum? newOrderStateEnum,
  }) {
    return OrderModel(
      orderId: orderId,
      cartModelList: newCartList ?? cartModelList,
      deliveryMethodModel: newDeliveryMethodModel ?? deliveryMethodModel,
      locationModel: newLocationModel ?? locationModel,
      totalPrice: newTotalPrice ?? totalPrice,
      checkoutDateAt: newCheckoutDateAt ?? checkoutDateAt,
      orderStateEnum: newOrderStateEnum ?? orderStateEnum,
    );
  }
}

@HiveType(typeId: 10)
enum OrderStateEnum {
  @HiveField(0)
  pending,
  @HiveField(1)
  cancel,
  @HiveField(2)
  delivered,
  @HiveField(3)
  transmit,
}
