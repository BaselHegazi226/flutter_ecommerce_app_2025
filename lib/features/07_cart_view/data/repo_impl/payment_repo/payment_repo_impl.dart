import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/security/payment_security_keys.dart';
import 'package:flutter_e_commerce_app_2025/core/services/payment_services.dart';

import '../../../../../core/errors/catch_error_handle.dart';
import '../../model/order_model.dart';
import '../../model/payment_response_model.dart';
import 'payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentServices paymentServices = PaymentServices();
  final Dio dio = Dio();
  final baseUrl = 'https://dummyjson.com';

  // Future<Either<Failure, void>> implementPayMobProcess(
  //   bool isDark,
  //   PaymentModel paymentModel,
  // ) async {
  //   try {
  //     PaymentData.initialize(
  //       apiKey: paymentModel
  //           .apiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
  //       iframeId: paymentModel
  //           .iframeId, // Required: Found under Developers -> iframes
  //       integrationCardId: paymentModel
  //           .integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
  //       integrationMobileWalletId: paymentModel
  //           .integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
  //       // Optional User Data
  //       userData: UserData(
  //         email: paymentModel.userEmail, // Optional: Defaults to 'NA'
  //         phone: paymentModel.userPhone, // Optional: Defaults to 'NA'
  //         name: paymentModel.userName, // Optional: Defaults to 'NA'
  //         lastName: paymentModel.userLastName, // Optional: Defaults to 'NA'
  //       ),
  //
  //       // Optional Style Customizations
  //       style: Style(
  //         primaryColor: isDark ? Colors.grey.shade200 : kPrimaryColor,
  //         scaffoldColor: isDark ? Colors.grey.shade700 : kScaffoldColor,
  //         appBarBackgroundColor: isDark ? Colors.grey.shade200 : kPrimaryColor,
  //         appBarForegroundColor: isDark
  //             ? Colors.grey.shade600
  //             : Colors.white, // Default: Colors.white
  //         buttonStyle:
  //             ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
  //         circleProgressColor: kPrimaryColor,
  //         unselectedColor: kGreyColor,
  //       ),
  //     );
  //     return right(null);
  //   } on DioException catch (e) {
  //     debugPrint('dio exceeeeeeeeee = ${e.message}');
  //     return left(FirebaseFailure(errorKey: e.message));
  //   } catch (e) {
  //     return left(FirebaseFailure(errorKey: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, PaymentResponseModel>> paymentPayMobIntention({
    required String currency,
    required OrderModel order,
    required String email,
    required String name,
  }) async {
    try {
      List<Map<String, dynamic>> items = [];
      int price = (order.totalPrice * 100).round();
      double sumBeforeRoundOfItems = 0;
      double sumAfterRoundOfItems = 0;

      debugPrint('total Price before round = ${(order.totalPrice) * 100}');
      debugPrint('total Price after round = $price');
      for (var item in order.cartModelList) {
        debugPrint(
          'price of ${item.title} = ${(item.price) * 100} before round',
        );
        debugPrint(
          'price of ${item.title} = ${(item.price * 100).round()} after round',
        );
        sumBeforeRoundOfItems += item.price * 100;
        sumAfterRoundOfItems += (item.price * 100).round();
        final x = {
          "name": item.title,
          "amount": (item.price * 100).round(),
          "description": "",
          "quantity": item.productCount,
        };
        items.add(x);
      }
      debugPrint('total Price before round of items = $sumBeforeRoundOfItems');
      debugPrint('total Price after round of items = $sumAfterRoundOfItems');
      debugPrint("items = $items");
      debugPrint('user name = $name');

      final response = await paymentServices.paymentIntention(
        endPoint: 'intention/',
        body: {
          "amount": price,
          "currency": currency.toUpperCase(),
          "payment_methods": [5379636],
          "items": items,
          "billing_data": {
            "apartment": "test apartment",
            "first_name": name,
            "last_name": " customer",
            "street": "test street",
            "building": "test building",
            "phone_number": "+201010101010",
            "city": "Cairo",
            "country": "EG",
            "email": email,
            "floor": "test floor",
            "state": "test state",
          },
          "extras": {"ee": 22},
          //
          // // ✅ دول إلزاميين في حالتك
          "redirection_url": "https://google.com",
          "notification_url": "https://webhook.site/test",

          // // ✅ اختياري
          // "expiration": 3600,
        },
        options: Options(
          headers: {
            'Authorization': 'Token ${PaymentSecurityKeys.secretKey}',
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      final data = response.data;
      debugPrint('data from request = $data =========================>');
      final paymentResponseModel = PaymentResponseModel.fromJson(data);
      return right(paymentResponseModel);
    } on DioException catch (e) {
      debugPrint('dio exceeeeeeeeee = ${e.message}');
      return left(FirebaseFailure(errorKey: e.message));
    } catch (e) {
      debugPrint('exception = $e');
      return left(FirebaseFailure(errorKey: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> paymentKeyRequest({
    required String currency,
    required OrderModel order,
    required String email,
    required String name,
  }) async {
    try {
      final payMobResponseModel = await paymentPayMobIntention(
        currency: currency,
        order: order,
        email: email,
        name: name,
      );
      debugPrint('name = $name, email = $email , currency = $currency');
      return payMobResponseModel.fold(
        (error) {
          debugPrint('exceeeeeeeeee = ${error.errorKey}');
          return left(error);
        },
        (success) async {
          final paymentToken = success.paymentKeys.first.key;
          final iframeUrl =
              "https://accept.paymobsolutions.com/api/acceptance/iframes/${PaymentSecurityKeys.iFrame}?payment_token=$paymentToken";
          debugPrint('✅ Redirect Url = $iframeUrl');

          return right(iframeUrl);
        },
      );
    } on DioException catch (e) {
      debugPrint('dio exceeeeeeeeee = ${e.message}');
      return left(FirebaseFailure(errorKey: e.message));
    } catch (e) {
      return left(FirebaseFailure(errorKey: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getPaymentState({required bool state}) async {
    try {
      if (state) {
        return right(true);
      } else {
        return right(false);
      }
    } on DioException catch (e) {
      debugPrint('dio exception : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    } on Exception catch (e) {
      debugPrint('exception : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    } catch (e) {
      debugPrint('exceptionnnnnnnnn : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    }
  }
}
