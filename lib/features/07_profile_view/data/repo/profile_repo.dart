import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> signOut();
}
