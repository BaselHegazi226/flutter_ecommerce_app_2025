import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final HomeViewRepo _homeViewRepo = HomeViewRepoImpl();

  ProductCubit() : super(GetProductInitial());

  Future<void> getAppProducts({String? category}) async {
    emit(GetProductLoading());
    final result = await _homeViewRepo.getAppProducts(category: category);
    result.fold(
      (error) {
        emit(
          GetProductFailure(errorMessage: error.errorKey ?? 'unknown error'),
        );
      },
      (successProducts) {
        emit(GetProductSuccess(products: successProducts));
      },
    );
  }

  Future<void> getProductsByCategory({required String category}) async {
    emit(GetProductByCategoryLoading());
    final result = await _homeViewRepo.getProductsByCategory(category);
    result.fold(
      (error) {
        emit(
          GetProductByCategoryFailure(
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (successProducts) {
        emit(GetProductByCategorySuccess(products: successProducts));
      },
    );
  }

  Future<void> getProductById({required int productId}) async {
    emit(GetProductByIdLoading());
    final result = await _homeViewRepo.getProductById(productId);
    result.fold(
      (error) {
        emit(
          GetProductByIdFailure(
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (successProduct) {
        emit(GetProductByIdSuccess(productModel: successProduct));
      },
    );
  }
}
