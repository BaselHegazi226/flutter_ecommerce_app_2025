import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/cart_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/delivery_method_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/location_model.dart';
import 'package:hive/hive.dart';

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
  final OrderState orderState;
  OrderModel({
    required this.orderId,
    required this.cartModelList,
    required this.deliveryMethodModel,
    required this.locationModel,
    required this.totalPrice,
    required this.checkoutDateAt,
    required this.orderState,
  });
  factory OrderModel.fromJson(json) {
    return OrderModel(
      orderId: json['orderId'],
      cartModelList: json['cartModel'],
      deliveryMethodModel: json['deliveryMethodModel'],
      locationModel: json['locationModel'],
      totalPrice: json['totalPrice'],
      checkoutDateAt: json['checkoutDateAt'],
      orderState: json['orderState'],
    );
  }
  OrderModel copyWith({
    List<CartModel>? newCartList,
    DeliveryMethodModel? newDeliveryMethodModel,
    LocationModel? newLocationModel,
    double? newTotalPrice,
    DateTime? newCheckoutDateAt,
    OrderState? newOrderState,
  }) {
    return OrderModel(
      orderId: orderId,
      cartModelList: newCartList ?? cartModelList,
      deliveryMethodModel: newDeliveryMethodModel ?? deliveryMethodModel,
      locationModel: newLocationModel ?? locationModel,
      totalPrice: newTotalPrice ?? totalPrice,
      checkoutDateAt: newCheckoutDateAt ?? checkoutDateAt,
      orderState: newOrderState ?? orderState,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'cartModel': cartModelList,
      'deliverMethodModel': deliveryMethodModel,
      'locationModel': locationModel,
      'totalPrice': totalPrice,
      'checkoutDateAt': checkoutDateAt,
      'orderState': orderState,
    };
  }
}

enum OrderState { pending, cancel, delivered, transmit }
