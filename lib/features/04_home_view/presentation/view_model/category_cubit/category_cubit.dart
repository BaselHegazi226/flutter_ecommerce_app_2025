import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/category_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeViewRepo homeViewRepo;
  CategoryCubit({required this.homeViewRepo}) : super(GetCategoryInitial());

  Future<void> getCategories() async {
    debugPrint('now in loading');
    emit(GetCategoryLoading());
    final result = await homeViewRepo.getCategories();
    result.fold(
      (error) {
        debugPrint('now in error category:: $error');
        emit(
          GetCategoryFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (successCategories) {
        debugPrint('now in success category:: $successCategories');
        emit(GetCategorySuccess(categories: successCategories));
      },
    );
  }
}
