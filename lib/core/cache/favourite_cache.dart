import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';
import 'package:hive/hive.dart';

import '../errors/failure.dart';
import '../helper/adapter_identifiers.dart';

abstract class FavouriteCache {
  Future<void> init();

  Future<Either<Failure, bool>> addFavouriteProduct({
    required FavouriteModel favouriteModel,
  });

  Future<Either<Failure, bool>> deleteFavouriteProduct({
    required FavouriteModel favouriteModel,
  });

  Future<Either<Failure, List<FavouriteModel>>> getFavouriteProducts();

  Future<Either<Failure, AddToFavouriteEnum>> getFavouriteProductById({
    required int productId,
  });
}

class FavouriteCacheImplement extends FavouriteCache {
  late Box<FavouriteModel> hiveBoxFavouriteProductModel;
  final String userId;

  FavouriteCacheImplement({required this.userId});

  @override
  Future<void> init() async {
    //register Adaptors
    FavouriteCacheAdaptorsClass.registerAllAdaptors();
    //open box
    final boxName = 'FavouriteProductBox$userId';
    hiveBoxFavouriteProductModel = Hive.isBoxOpen(boxName)
        ? Hive.box<FavouriteModel>(boxName)
        : await Hive.openBox<FavouriteModel>(boxName);
  }

  @override
  Future<Either<Failure, bool>> addFavouriteProduct({
    required FavouriteModel favouriteModel,
  }) async {
    try {
      if (hiveBoxFavouriteProductModel.get(favouriteModel.id) == null) {
        final favouriteModelIndependent = FavouriteModel.fromJson(
          favouriteModel.toJson(),
        );
        await hiveBoxFavouriteProductModel.put(
          favouriteModelIndependent.id,
          favouriteModelIndependent,
        );
      }
      return right(true);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFavouriteProduct({
    required FavouriteModel favouriteModel,
  }) async {
    try {
      if (hiveBoxFavouriteProductModel.get(favouriteModel.id) != null) {
        final favouriteModelIndependent = FavouriteModel.fromJson(
          favouriteModel.toJson(),
        );
        await hiveBoxFavouriteProductModel.delete(favouriteModelIndependent.id);
        return right(true);
      } else {
        return right(false);
      }
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  @override
  Future<Either<Failure, List<FavouriteModel>>> getFavouriteProducts() async {
    try {
      List<FavouriteModel> favouriteList = hiveBoxFavouriteProductModel.values
          .map((item) {
            return item.copyWith();
          })
          .toList();

      // ترتيب السلة حسب وقت الإضافة (الأحدث أولاً)
      favouriteList.sort((a, b) => b.addAt.compareTo(a.addAt));

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
    if (!Hive.isAdapterRegistered(AdaptorsIdentifiers.favouriteModelAdapter)) {
      Hive.registerAdapter(FavouriteModelAdapter());
    }
  }
}
