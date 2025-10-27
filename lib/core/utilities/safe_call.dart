import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return right(result);
  } catch (e) {
    return left(CatchErrorHandle.catchBack(failure: e));
  }
}
