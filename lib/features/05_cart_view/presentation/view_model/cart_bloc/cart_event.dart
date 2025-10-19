part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class AddToCartEvent extends CartEvent {
  final CartModel cartModel;
  AddToCartEvent({required this.cartModel});
}

final class DeleteProductEvent extends CartEvent {
  final CartModel cartModel;
  DeleteProductEvent({required this.cartModel});
}

final class DeleteAllProductsEvent extends CartEvent {}

final class UpdateProductCountEvent extends CartEvent {
  final int productId;
  final int newCount;
  UpdateProductCountEvent({required this.newCount, required this.productId});
}
