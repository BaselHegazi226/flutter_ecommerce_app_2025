import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import 'home_view_repo.dart';

class HomeViewRepoImpl implements HomeViewRepo {
  static const _baseUrl = 'https://dummyjson.com';
  Dio dio = Dio();

  @override
  Future<Either<Failure, List<ProductModel>>> getAppProducts({
    String? category = 'SmartPhones',
  }) async {
    try {
      final Response response = await dio.get(
        '$_baseUrl/products/category/$category',
      );
      final data = response.data['products'];
      debugPrint('data data data data data = $data');
      List<ProductModel> products = [];
      for (var item in data) {
        final model = ProductModel.fromJson(item);
        debugPrint('model best selling = ${model.toJson()}');
        products.add(model);
      }
      return right(products);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      //get category from my firebase ecommerce firestore
      // final CollectionReference collectionReference = FirebaseFirestore.instance
      //     .collection('category');
      // final snapShot = await collectionReference.get();
      // List<CategoryModel> categories = snapShot.docs.map((doc) {
      //   return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
      // }).toList();
      final Response response = await dio.get('$_baseUrl/products/categories');
      final data = response.data;
      List<CategoryModel> categories = [];
      for (var item in data) {
        final model = CategoryModel.fromJson(item);
        debugPrint('model categories = $model');
        categories.add(model);
      }
      return right(categories);
    } catch (e) {
      debugPrint('error from category : $e');
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final Response response = await dio.get(
        '$_baseUrl/products/category/$category',
      );
      debugPrint('category $category==================>');
      final data = response.data['products'];
      List<ProductModel> products = [];
      for (var item in data) {
        final model = ProductModel.fromJson(item);
        debugPrint('model = ${model.toJson()}');
        products.add(model);
      }
      debugPrint('products ${products.toString()}==================>');
      return right(products);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int productId) async {
    try {
      final response = await dio.get('$_baseUrl/products/$productId');
      final data = response.data;
      final model = ProductModel.fromJson(data);
      return right(model);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> showAllProducts() async {
    try {
      final Response response = await dio.get('$_baseUrl/products');
      final data = response.data['products'];
      debugPrint('data data data data data = $data');
      List<ProductModel> products = [];
      for (var item in data) {
        final model = ProductModel.fromJson(item);
        debugPrint('model best selling = ${model.toJson()}');
        products.add(model);
      }
      return right(products);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}
