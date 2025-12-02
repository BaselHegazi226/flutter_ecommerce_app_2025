import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/payment_model.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> implementPayMobProcess(
    bool isDark,
    PaymentModel paymentModel,
  );
}
