part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class GetCategoryInitial extends CategoryState {}

final class GetCategoryLoading extends CategoryState {}

final class GetCategoryFailure extends CategoryState {
  final String errorMessage;

  GetCategoryFailure({required this.errorMessage});
}

final class GetCategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  GetCategorySuccess({required this.categories});
}
