import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';

abstract class HomeViewRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, List<ProductModel>>> getAppProducts({
    required String? category,
  });

  Future<Either<Failure, List<ProductModel>>> showAllProducts();

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category,
  );

  Future<Either<Failure, ProductModel>> getProductById(final int productId);
}
