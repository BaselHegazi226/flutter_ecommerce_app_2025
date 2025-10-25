import '../../../data/model/cart_model.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

final class AddToCartInitial extends CartState {}

final class AddToCartLoading extends CartState {}

final class AddToCartFailure extends CartState {
  final String errorMessage;
  AddToCartFailure({required this.errorMessage});
}

final class AddToCartSuccess extends CartState {}

final class AddToCartDone extends CartState {}

final class UpdateProductCountInitial extends CartState {}

final class UpdateProductCountLoading extends CartState {}

final class UpdateProductCountFailure extends CartState {
  final String errorMessage;
  UpdateProductCountFailure({required this.errorMessage});
}

final class UpdateProductCountSuccess extends CartState {
  final List<CartModel> updateCartList;
  UpdateProductCountSuccess({required this.updateCartList});
}

final class DeleteProductInitial extends CartState {}

final class DeleteProductLoading extends CartState {}

final class DeleteProductFailure extends CartState {
  final String errorMessage;
  DeleteProductFailure({required this.errorMessage});
}

final class DeleteProductSuccess extends CartState {}

final class DeleteAllProductInitial extends CartState {}

final class DeleteAllProductLoading extends CartState {}

final class DeleteAllProductFailure extends CartState {
  final String errorMessage;
  DeleteAllProductFailure({required this.errorMessage});
}

final class DeleteAllProductSuccess extends CartState {}
