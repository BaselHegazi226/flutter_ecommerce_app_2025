import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../05_home_view/data/model/product_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ProductModel>>> getSearchResultWithCategory({
    required String category,
  });
}
