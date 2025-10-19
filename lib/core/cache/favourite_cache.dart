import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:hive/hive.dart';

import '../../features/04_home_view/data/model/product_model.dart';
import '../errors/failure.dart';
import '../helper/adapter_identifiers.dart';

abstract class FavouriteCache {
  Future<void> init();
  Future<Either<Failure, bool>> addFavouriteProduct({
    required ProductModel productModel,
  });
  Future<Either<Failure, bool>> deleteFavouriteProduct({
    required ProductModel productModel,
  });
  Future<Either<Failure, List<ProductModel>>> getFavouriteProducts();
  Future<Either<Failure, AddToFavouriteEnum>> getFavouriteProductById({
    required int productId,
  });
}

class FavouriteCacheImplement extends FavouriteCache {
  late Box<ProductModel> hiveBoxFavouriteProductModel;
  final String userId;

  FavouriteCacheImplement({required this.userId});

  @override
  Future<void> init() async {
    //register Adaptors
    FavouriteCacheAdaptorsClass.registerAllAdaptors();
    //open box
    final boxName = 'favouriteProduct$userId';
    hiveBoxFavouriteProductModel = Hive.isBoxOpen(boxName)
        ? Hive.box<ProductModel>(boxName)
        : await Hive.openBox<ProductModel>(boxName);
  }

  @override
  Future<Either<Failure, bool>> addFavouriteProduct({
    required ProductModel productModel,
  }) async {
    try {
      if (hiveBoxFavouriteProductModel.get(productModel.id) == null) {
        final productModelIndependent = ProductModel.fromJson(
          productModel.toJson(),
        );
        await hiveBoxFavouriteProductModel.put(
          productModelIndependent.id,
          productModelIndependent,
        );
      }
      return right(true);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFavouriteProduct({
    required ProductModel productModel,
  }) async {
    try {
      if (hiveBoxFavouriteProductModel.get(productModel.id) != null) {
        final productModelIndependent = ProductModel.fromJson(
          productModel.toJson(),
        );
        await hiveBoxFavouriteProductModel.delete(productModelIndependent.id);
        return right(true);
      } else {
        return right(false);
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFavouriteProducts() async {
    try {
      List<ProductModel> favouriteList = hiveBoxFavouriteProductModel.values
          .map((item) {
            final independentProduct = ProductModel.fromJson(item.toJson());
            return independentProduct;
          })
          .toList();
      return right(favouriteList);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, AddToFavouriteEnum>> getFavouriteProductById({
    required int productId,
  }) async {
    try {
      if (hiveBoxFavouriteProductModel.get(productId) != null) {
        return right(AddToFavouriteEnum.added);
      } else {
        return right(AddToFavouriteEnum.notAdded);
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}

enum AddToFavouriteEnum { added, notAdded }

class FavouriteCacheAdaptorsClass {
  static void registerAllAdaptors() {
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.metaModelAdapter)) {
      Hive.registerAdapter(MetaAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.productModelAdapter)) {
      Hive.registerAdapter(ProductModelAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.dimensionModelAdapter)) {
      Hive.registerAdapter(DimensionsAdapter());
    }
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.reviewModelAdapter)) {
      Hive.registerAdapter(ReviewAdapter());
    }
  }
}

enum AddToCartEnum { added, notAdded }
