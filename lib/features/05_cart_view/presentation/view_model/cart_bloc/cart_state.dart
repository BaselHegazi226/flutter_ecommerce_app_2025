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

//update product local
final class UpdateProductCountInitial extends CartState {}

final class UpdateProductCountLoading extends CartState {}

final class UpdateProductCountFailure extends CartState {
  final String errorMessage;

  UpdateProductCountFailure({required this.errorMessage});
}

final class UpdateProductCountSuccess extends CartState {}

//update product on firebase
final class UpdateProductCountFailureOnline extends CartState {
  final String errorMessage;

  UpdateProductCountFailureOnline({required this.errorMessage});
}

final class UpdateProductCountSuccessOnline extends CartState {}

//delete product local
final class DeleteProductInitial extends CartState {}

final class DeleteProductLoading extends CartState {}

final class DeleteProductFailure extends CartState {
  final String errorMessage;

  DeleteProductFailure({required this.errorMessage});
}

final class DeleteProductSuccess extends CartState {}

//delete product on firebase
final class DeleteProductFailureOnline extends CartState {
  final String errorMessage;

  DeleteProductFailureOnline({required this.errorMessage});
}

final class DeleteProductSuccessOnline extends CartState {}

//delete all products local
final class DeleteAllProductInitial extends CartState {}

final class DeleteAllProductLoading extends CartState {}

final class DeleteAllProductFailure extends CartState {
  final String errorMessage;

  DeleteAllProductFailure({required this.errorMessage});
}

final class DeleteAllProductSuccess extends CartState {}

//delete all products online
final class DeleteAllProductFailureOnline extends CartState {
  final String errorMessage;

  DeleteAllProductFailureOnline({required this.errorMessage});
}

final class DeleteAllProductSuccessOnline extends CartState {}
