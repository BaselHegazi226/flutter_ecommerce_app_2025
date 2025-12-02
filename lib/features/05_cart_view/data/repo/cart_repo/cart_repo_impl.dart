import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/payment_model.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

import 'cart_repo.dart';

class CartRepoImpl implements CartRepo {
  @override
  Future<Either<Failure, void>> implementPayMobProcess(
    bool isDark,
    PaymentModel paymentModel,
  ) async {
    try {
      PaymentData.initialize(
        apiKey: paymentModel
            .apiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
        iframeId: paymentModel
            .iframeId, // Required: Found under Developers -> iframes
        integrationCardId: paymentModel
            .integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
        integrationMobileWalletId: paymentModel
            .integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
        // Optional User Data
        userData: UserData(
          email: paymentModel.userEmail, // Optional: Defaults to 'NA'
          phone: paymentModel.userPhone, // Optional: Defaults to 'NA'
          name: paymentModel.userName, // Optional: Defaults to 'NA'
          lastName: paymentModel.userLastName, // Optional: Defaults to 'NA'
        ),

        // Optional Style Customizations
        style: Style(
          primaryColor: isDark ? Colors.grey.shade200 : kPrimaryColor,
          scaffoldColor: isDark ? Colors.grey.shade700 : kScaffoldColor,
          appBarBackgroundColor: isDark ? Colors.grey.shade200 : kPrimaryColor,
          appBarForegroundColor: isDark
              ? Colors.grey.shade600
              : Colors.white, // Default: Colors.white
          buttonStyle:
              ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
          circleProgressColor: kPrimaryColor,
          unselectedColor: kGreyColor,
        ),
      );
      return right(null);
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}
