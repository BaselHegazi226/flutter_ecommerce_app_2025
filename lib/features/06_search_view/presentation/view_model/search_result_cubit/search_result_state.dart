part of 'search_result_cubit.dart';

@immutable
sealed class SearchResultState {}

final class SearchResultInitial extends SearchResultState {}

final class GetSearchResultInitial extends SearchResultState {}

final class GetSearchResultLoading extends SearchResultState {}

final class GetSearchResultFailure extends SearchResultState {
  final String errorMessage;

  GetSearchResultFailure({required this.errorMessage});
}

final class GetSearchResultSuccess extends SearchResultState {
  final List<ProductModel> products;

  GetSearchResultSuccess({required this.products});
}
