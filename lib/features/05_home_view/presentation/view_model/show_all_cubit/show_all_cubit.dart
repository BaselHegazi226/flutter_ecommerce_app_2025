import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';
import '../../../data/repo/home_view_repo.dart';
import '../../../data/repo/home_view_repo_impl.dart';

part 'show_all_state.dart';

class ShowAllCubit extends Cubit<ShowAllState> {
  final HomeViewRepo homeViewRepo = HomeViewRepoImpl();

  ShowAllCubit() : super(ShowAllInitial());

  Future<void> showAllProduct() async {
    emit(ShowAllLoading());
    final result = await homeViewRepo.showAllProducts();
    result.fold(
      (error) {
        emit(ShowAllFailure(errorMessage: error.errorKey ?? 'unknown error'));
      },
      (showAllProductSuccess) {
        emit(ShowAllSuccess(products: showAllProductSuccess));
      },
    );
  }
}
