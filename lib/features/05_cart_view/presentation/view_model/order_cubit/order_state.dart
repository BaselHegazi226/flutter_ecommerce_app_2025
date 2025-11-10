import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/location_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';

abstract class OrderState {}

final class OrderInitial extends OrderState {}

final class SaveUserLocationInitial extends OrderState {}

final class SaveUserLocationLoading extends OrderState {}

final class SaveUserLocationSuccess extends OrderState {}

final class SaveUserLocationFailure extends OrderState {
  final String errorMessage;

  SaveUserLocationFailure({required this.errorMessage});
}

final class GetUserLocationInitial extends OrderState {}

final class GetUserLocationLoading extends OrderState {}

final class GetUserLocationSuccess extends OrderState {
  final LocationModel locationModel;

  GetUserLocationSuccess({required this.locationModel});
}

final class GetUserLocationFailure extends OrderState {
  final String errorMessage;

  GetUserLocationFailure({required this.errorMessage});
}

final class AddOrderInitial extends OrderState {}

final class AddOrderLoading extends OrderState {}

final class AddOrderFailure extends OrderState {
  final String errorMessage;

  AddOrderFailure({required this.errorMessage});
}

final class AddOrderSuccess extends OrderState {}

final class GetOrderListInitial extends OrderState {}

final class GetOrderListLoading extends OrderState {}

final class GetOrderListFailure extends OrderState {
  final String errorMessage;

  GetOrderListFailure({required this.errorMessage});
}

final class GetOrderStateInitial extends OrderState {}

final class GetOrderStateLoading extends OrderState {}

final class GetOrderStateFailure extends OrderState {
  final String errorMessage;

  GetOrderStateFailure({required this.errorMessage});
}

final class GetOrderStateSuccess extends OrderState {
  final OrderModel orderModel;

  GetOrderStateSuccess({required this.orderModel});
}

final class GetOrderListSuccess extends OrderState {
  final List<OrderModel> orders;

  GetOrderListSuccess({required this.orders});
}

final class DeleteOrderInitial extends OrderState {}

final class DeleteOrderLoading extends OrderState {}

final class DeleteOrderFailure extends OrderState {
  final String errorMessage;

  DeleteOrderFailure({required this.errorMessage});
}

final class DeleteOrderSuccess extends OrderState {}

final class DeleteMultipleOrdersInitial extends OrderState {}

final class DeleteMultipleOrdersLoading extends OrderState {}

final class DeleteMultipleOrdersFailure extends OrderState {
  final String errorMessage;

  DeleteMultipleOrdersFailure({required this.errorMessage});
}

final class DeleteAllOrdersInitial extends OrderState {}

final class DeleteAllOrdersLoading extends OrderState {}

final class DeleteAllOrdersFailure extends OrderState {
  final String errorMessage;

  DeleteAllOrdersFailure({required this.errorMessage});
}

final class DeleteAllOrdersSuccess extends OrderState {}

final class DeleteMultipleOrdersSuccess extends OrderState {}

final class UpdateOrderInitial extends OrderState {}

final class UpdateOrderLoading extends OrderState {}

final class UpdateOrderFailure extends OrderState {
  final String errorMessage;

  UpdateOrderFailure({required this.errorMessage});
}

final class UpdateOrderSuccess extends OrderState {
  final OrderModel order;

  UpdateOrderSuccess({required this.order});
}
