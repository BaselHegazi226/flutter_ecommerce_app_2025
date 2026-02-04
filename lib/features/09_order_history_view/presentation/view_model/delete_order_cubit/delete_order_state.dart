part of 'delete_order_cubit.dart';

@immutable
sealed class DeleteOrderState {}

final class DeleteOrderInitial extends DeleteOrderState {}

final class DeleteOrderLoading extends DeleteOrderState {}

final class DeleteOrderFailure extends DeleteOrderState {
  final String errorMessage;

  DeleteOrderFailure({required this.errorMessage});
}

final class DeleteOrderSuccess extends DeleteOrderState {}

final class DeleteMultipleOrdersInitial extends DeleteOrderState {}

final class DeleteMultipleOrdersLoading extends DeleteOrderState {}

final class DeleteMultipleOrdersFailure extends DeleteOrderState {
  final String errorMessage;

  DeleteMultipleOrdersFailure({required this.errorMessage});
}

final class DeleteAllOrdersInitial extends DeleteOrderState {}

final class DeleteAllOrdersLoading extends DeleteOrderState {}

final class DeleteAllOrdersFailure extends DeleteOrderState {
  final String errorMessage;

  DeleteAllOrdersFailure({required this.errorMessage});
}

final class DeleteAllOrdersSuccess extends DeleteOrderState {}

final class DeleteMultipleOrdersSuccess extends DeleteOrderState {}
