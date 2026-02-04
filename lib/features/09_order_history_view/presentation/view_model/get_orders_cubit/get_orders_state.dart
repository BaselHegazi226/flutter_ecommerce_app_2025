part of 'get_orders_cubit.dart';

@immutable
sealed class GetOrdersState {}

final class GetOrdersInitial extends GetOrdersState {}

final class GetOrdersLoading extends GetOrdersState {}

final class GetOrdersFailure extends GetOrdersState {
  final String errorMessage;

  GetOrdersFailure({required this.errorMessage});
}

final class GetOrdersSuccess extends GetOrdersState {
  final List<OrderModel> orders;

  GetOrdersSuccess({required this.orders});
}
