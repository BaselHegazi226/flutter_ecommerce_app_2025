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

final class GetProductByCategoryNumberInitial extends ProductState {}

final class GetProductByCategoryNumberLoading extends ProductState {}

final class GetProductByCategoryNumberFailure extends ProductState {
  final String errorMessage;

  GetProductByCategoryNumberFailure({required this.errorMessage});
}

final class GetProductByCategoryNumberSuccess extends ProductState {
  final List<ProductModel> products;

  GetProductByCategoryNumberSuccess({required this.products});
}
