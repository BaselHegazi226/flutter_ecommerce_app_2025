part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class GetProductInitial extends ProductState {}

final class GetProductLoading extends ProductState {}

final class GetProductFailure extends ProductState {
  final String errorMessage;

  GetProductFailure({required this.errorMessage});
}

final class GetProductSuccess extends ProductState {
  final List<ProductModel> products;

  GetProductSuccess({required this.products});
}

final class GetProductByCategoryInitial extends ProductState {}

final class GetProductByCategoryLoading extends ProductState {}

final class GetProductByCategoryFailure extends ProductState {
  final String errorMessage;

  GetProductByCategoryFailure({required this.errorMessage});
}

final class GetProductByCategorySuccess extends ProductState {
  final List<ProductModel> products;

  GetProductByCategorySuccess({required this.products});
}

final class GetProductByIdInitial extends ProductState {}

final class GetProductByIdLoading extends ProductState {}

final class GetProductByIdFailure extends ProductState {
  final String errorMessage;

  GetProductByIdFailure({required this.errorMessage});
}

final class GetProductByIdSuccess extends ProductState {
  final ProductModel productModel;

  GetProductByIdSuccess({required this.productModel});
}
