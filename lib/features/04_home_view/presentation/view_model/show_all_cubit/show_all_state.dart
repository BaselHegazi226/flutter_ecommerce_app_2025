part of 'show_all_cubit.dart';

@immutable
sealed class ShowAllState {}

final class ShowAllInitial extends ShowAllState {}

final class ShowAllLoading extends ShowAllState {}

final class ShowAllFailure extends ShowAllState {
  final String errorMessage;

  ShowAllFailure({required this.errorMessage});
}

final class ShowAllSuccess extends ShowAllState {
  final List<ProductModel> products;

  ShowAllSuccess({required this.products});
}
