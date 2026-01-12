import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../05_home_view/data/model/product_model.dart';
import '../../../data/repo/search_repo.dart';
import '../../../data/repo/search_repo_impl.dart';

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
            errorMessage: error.errorKey ?? 'unknown error',
          ),
        );
      },
      (productsSuccess) {
        emit(GetSearchResultSuccess(products: productsSuccess));
      },
    );
  }
}
