import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final HomeViewRepo homeViewRepo;
  ProductCubit({required this.homeViewRepo}) : super(GetProductInitial());
  Future<void> getBestSellingProducts() async {
    emit(GetProductLoading());
    final result = await homeViewRepo.getBestSellingProducts();
    result.fold(
      (error) {
        emit(
          GetProductFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (successProducts) {
        emit(GetProductSuccess(products: successProducts));
      },
    );
  }

  Future<void> getProductsByCategory({required String category}) async {
    emit(GetProductByCategoryLoading());
    final result = await homeViewRepo.getProductsByCategory(category);
    result.fold(
      (error) {
        emit(
          GetProductByCategoryFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
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
    final result = await homeViewRepo.getProductById(productId);
    result.fold(
      (error) {
        emit(
          GetProductByIdFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (successProduct) {
        emit(GetProductByIdSuccess(productModel: successProduct));
      },
    );
  }
}
