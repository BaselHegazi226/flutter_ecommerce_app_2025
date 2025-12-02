import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/data/repo/search_repo.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/data/repo/search_repo_impl.dart';
import 'package:meta/meta.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  final SearchRepo searchRepo = SearchRepoImpl();

  SearchResultCubit() : super(SearchResultInitial());

  Future<void> getSearchResultByCategory({required String category}) async {
    emit(GetSearchResultLoading());
    final result = await searchRepo.getSearchResultWithCategory(
      category: category,
    );
    result.fold(
      (error) {
        emit(
          GetSearchResultFailure(
            errorMessage: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (productsSuccess) {
        emit(GetSearchResultSuccess(products: productsSuccess));
      },
    );
  }
}
