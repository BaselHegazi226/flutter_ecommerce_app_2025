import '../../../data/model/cart_model.dart';

abstract class GetCartState {}

final class GetCartInitial extends GetCartState {}

final class GetProductCartAndTotalInitial extends GetCartState {}

final class GetProductCartAndTotalLoading extends GetCartState {}

final class GetProductCartAndTotalFailure extends GetCartState {
  final String errorMessage;
  GetProductCartAndTotalFailure({required this.errorMessage});
}

final class GetProductCartAndTotalSuccess extends GetCartState {
  final List<CartModel> carts;
  final double totalPrice;
  GetProductCartAndTotalSuccess({
    required this.carts,
    required this.totalPrice,
  });
}
