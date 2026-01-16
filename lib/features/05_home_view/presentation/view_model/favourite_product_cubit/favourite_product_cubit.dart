import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';

import '../../../../../core/cache/favourite_cache.dart';

part 'favourite_product_state.dart';

class FavouriteProductCubit extends Cubit<FavouriteProductState> {
  final FavouriteCache favouriteCache;

  FavouriteProductCubit({required this.favouriteCache})
    : super(FavouriteProductInitial());

  Future<void> addFavoriteProduct({
    required FavouriteModel favouriteModel,
  }) async {
    emit(AddFavouriteProductLoading());
    final result = await favouriteCache.addFavouriteProduct(
      favouriteModel: favouriteModel,
    );
    result.fold(
      (error) {
        emit(
          AddFavouriteProductFailure(
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(AddFavouriteProductSuccess());
      },
    );
  }

  Future<void> deleteFavoriteProduct({
    required FavouriteModel favouriteModel,
  }) async {
    emit(DeleteFavouriteProductLoading());
    final result = await favouriteCache.deleteFavouriteProduct(
      favouriteModel: favouriteModel,
    );
    result.fold(
      (error) {
        emit(
          DeleteFavouriteProductFailure(
            errorMessage: error.errorKey ?? 'unknown error',
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
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (success) {
        emit(GetFavouriteProductsSuccess(favouriteList: success));
      },
    );
  }

  Future<void> getFavouriteProductById({required int productId}) async {
    emit(GetFavouriteProductByIdLoading());
    final result = await favouriteCache.getFavouriteProductById(
      productId: productId,
    );
    result.fold(
      (error) {
        emit(
          GetFavouriteProductByIdFailure(
            errorMessage: error.errorKey ?? 'unknown error',
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
