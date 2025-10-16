part of 'favourite_product_cubit.dart';

@immutable
sealed class FavouriteProductState {}

final class FavouriteProductInitial extends FavouriteProductState {}

final class AddFavouriteProductInitial extends FavouriteProductState {}

final class AddFavouriteProductLoading extends FavouriteProductState {}

final class AddFavouriteProductFailure extends FavouriteProductState {
  final String errorMessage;
  AddFavouriteProductFailure({required this.errorMessage});
}

final class AddFavouriteProductSuccess extends FavouriteProductState {}

final class DeleteFavouriteProductInitial extends FavouriteProductState {}

final class DeleteFavouriteProductLoading extends FavouriteProductState {}

final class DeleteFavouriteProductFailure extends FavouriteProductState {
  final String errorMessage;
  DeleteFavouriteProductFailure({required this.errorMessage});
}

final class DeleteFavouriteProductSuccess extends FavouriteProductState {}

final class GetFavouriteProductsInitial extends FavouriteProductState {}

final class GetFavouriteProductsLoading extends FavouriteProductState {}

final class GetFavouriteProductsFailure extends FavouriteProductState {
  final String errorMessage;

  GetFavouriteProductsFailure({required this.errorMessage});
}

final class GetFavouriteProductsSuccess extends FavouriteProductState {
  final List<ProductModel> favouriteList;

  GetFavouriteProductsSuccess({required this.favouriteList});
}

final class GetFavouriteProductByIdInitial extends FavouriteProductState {}

final class GetFavouriteProductByIdLoading extends FavouriteProductState {}

final class GetFavouriteProductByIdFailure extends FavouriteProductState {
  final String errorMessage;

  GetFavouriteProductByIdFailure({required this.errorMessage});
}

final class GetFavouriteProductByIdSuccess extends FavouriteProductState {}

final class GetFavouriteProductByIdDone extends FavouriteProductState {}
