import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/user_info_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/catch_error_handle.dart';
import 'package:flutter_e_commerce_app_2025/core/security/payment_security_keys.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/payment_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/repo/cart_repo/cart_repo.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/repo/cart_repo/cart_repo_impl.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CartRepo cartRepo = CartRepoImpl();
  final UserInfoCacheImplement userInfoCacheImplement =
      UserInfoCacheImplement();
  PaymentBloc() : super(PaymentInitial()) {
    on<ImplementPaymentWithPayMobEvent>(_onImplementPaymentWithPayMobEvent);
  }
  Future<void> _onImplementPaymentWithPayMobEvent(
    ImplementPaymentWithPayMobEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(ImplementPaymentWithPayMobLoading());
    final result1 = await userInfoCacheImplement.getUser();
    result1.fold(
      (error) {
        return left(
          CatchErrorHandle.catchBack(
            failure: error.errorMessage ?? 'unknown error',
          ),
        );
      },
      (successUserFound) async {
        if (successUserFound != null) {
          PaymentModel paymentModel = PaymentModel(
            userEmail: successUserFound.email,
            userName: successUserFound.name,
            userLastName: '',
            userPhone: '010010101010',
            integrationMobileWalletId:
                PaymentSecurityKeys.mobileWalletIntegrationId,
            integrationCardId: PaymentSecurityKeys.paymentIntegrationId,
            iframeId: PaymentSecurityKeys.iFrame,
            apiKey: PaymentSecurityKeys.apiKey,
          );
          final result = await cartRepo.implementPayMobProcess(
            event.isDark,
            paymentModel,
          );

          result.fold(
            (error) {
              emit(
                ImplementPaymentWithPayMobFailure(
                  errorMessage: error.errorMessage ?? 'unknown error',
                ),
              );
            },
            (success) {
              emit(ImplementPaymentWithPayMobSuccess());
            },
          );
        } else {
          return left(
            CatchErrorHandle.catchBack(
              failure: "No User Data Found please sign in again!",
            ),
          );
        }
      },
    );
  }
}
