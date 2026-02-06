import '../../../../07_cart_view/data/model/location_model.dart';
import '../../../../07_cart_view/data/model/order_model.dart';

abstract class OrderState {}

final class OrderInitial extends OrderState {}

final class SaveOrderInfoInitial extends OrderState {}

final class SaveOrderInfoLoading extends OrderState {}

final class SaveOrderInfoSuccess extends OrderState {}

final class SaveOrderInfoFailure extends OrderState {
  final String errorMessage;

  SaveOrderInfoFailure({required this.errorMessage});
}

final class GetOrderInfoInitial extends OrderState {}

final class GetOrderInfoLoading extends OrderState {}

final class GetOrderInfoSuccess extends OrderState {
  final OrderInfoModel orderInfoModel;

  GetOrderInfoSuccess({required this.orderInfoModel});
}

final class GetOrderInfoFailure extends OrderState {
  final String errorMessage;

  GetOrderInfoFailure({required this.errorMessage});
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
