import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/category_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';

abstract class HomeViewRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<ProductModel>>> getBestSellingProducts();
  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryNumber(
    String category,
  );
}
