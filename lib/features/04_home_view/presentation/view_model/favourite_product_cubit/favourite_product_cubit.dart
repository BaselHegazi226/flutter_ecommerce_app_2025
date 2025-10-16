import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:meta/meta.dart';

import '../../../../../core/cache/favourite_cache.dart';

part 'favourite_product_state.dart';

class FavouriteProductCubit extends Cubit<FavouriteProductState> {
  final FavouriteCache favouriteCache;
  FavouriteProductCubit({required this.favouriteCache})
    : super(FavouriteProductInitial());

  Future<void> addFavoriteProduct({required ProductModel productModel}) async {
    emit(AddFavouriteProductLoading());
    final result = await favouriteCache.addFavouriteProduct(
      productModel: productModel,
    );
    result.fold(
      (error) {
        emit(
          AddFavouriteProductFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(AddFavouriteProductSuccess());
      },
    );
  }

  Future<void> deleteFavoriteProduct({
    required ProductModel productModel,
  }) async {
    emit(DeleteFavouriteProductLoading());
    final result = await favouriteCache.deleteFavouriteProduct(
      productModel: productModel,
    );
    result.fold(
      (error) {
        emit(
          DeleteFavouriteProductFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(DeleteFavouriteProductSuccess());
      },
    );
  }

  Future<void> getFavouriteProducts() async {
    emit(GetFavouriteProductsLoading());
    final result = await favouriteCache.getFavouriteProducts();
    result.fold(
      (error) {
        emit(
          GetFavouriteProductsFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(GetFavouriteProductsSuccess(favouriteList: success));
      },
    );
  }

  Future<void> getFavouriteProductById({
    required ProductModel productModel,
  }) async {
    emit(GetFavouriteProductByIdLoading());
    final result = await favouriteCache.getFavouriteProductById(
      productModel: productModel,
    );
    result.fold(
      (error) {
        emit(
          GetFavouriteProductByIdFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (success) {
        if (success == AddToFavouriteEnum.added) {
          emit(GetFavouriteProductByIdSuccess());
        } else {
          emit(GetFavouriteProductByIdDone());
        }
      },
    );
  }
}
