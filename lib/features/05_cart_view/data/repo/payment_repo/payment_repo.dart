import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/payment_response_model.dart';

import '../../model/order_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, PaymentResponseModel>> paymentPayMobIntention({
    required String currency,
    required OrderModel order,
    required String email,
    required String name,
  });

  Future<Either<Failure, String>> paymentKeyRequest({
    required String currency,
    required OrderModel order,
    required String email,
    required String name,
  });

  Future<Either<Failure, bool>> getPaymentState({required bool state});
}
