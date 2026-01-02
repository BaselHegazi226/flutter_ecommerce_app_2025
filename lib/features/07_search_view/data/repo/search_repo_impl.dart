import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/data/repo/search_repo.dart';

import '../../../../core/helper/const.dart';

class SearchRepoImpl implements SearchRepo {
  final baseUrl = 'https://dummyjson.com';
  Dio dio = Dio();

  @override
  Future<Either<Failure, List<ProductModel>>> getSearchResultWithCategory({
    required String category,
  }) async {
    try {
      final slug = searchFilter(category);
      final response = await dio.get('$baseUrl/products/category/$slug');
      final data = response.data['products'];
      List<ProductModel> products = [];
      for (var item in data) {
        ProductModel productModel = ProductModel.fromJson(item);
        products.add(productModel);
      }
      debugPrint('products in search = ${products.toString()}');
      return right(products);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}
