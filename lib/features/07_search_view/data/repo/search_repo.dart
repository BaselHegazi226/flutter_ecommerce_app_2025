import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';

import '../../../../core/errors/failure.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ProductModel>>> getSearchResultWithCategory({
    required String category,
  });
}
