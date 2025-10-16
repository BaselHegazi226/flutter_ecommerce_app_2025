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

  Future<void> getProductsByCategoryNumber({required String category}) async {
    emit(GetProductByCategoryNumberLoading());
    final result = await homeViewRepo.getProductsByCategoryNumber(category);
    result.fold(
      (error) {
        emit(
          GetProductByCategoryNumberFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (successProducts) {
        emit(GetProductByCategoryNumberSuccess(products: successProducts));
      },
    );
  }
}
