import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/services/user_services.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';

import '../../../../../core/cache/user_info_cache.dart';
import '../../../../02_auth_view/data/model/user_model.dart';
import '../../../data/repo_impl/payment_repo/payment_repo.dart';
import '../../../data/repo_impl/payment_repo/payment_repo_impl.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepo paymentRepo = PaymentRepoImpl();
  final UserInfoCacheImplement userInfoCache = UserInfoCacheImplement();
  final UserServices userServices = UserServices();
  PaymentBloc() : super(PaymentInitial()) {
    on<ImplementPaymentWithPayMobEvent>(_onImplementPaymentWithPayMobEvent);
    on<GetPaymentStateEvent>(_onGetPaymentStateEvent);
  }
  Future<void> _onImplementPaymentWithPayMobEvent(
    ImplementPaymentWithPayMobEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(ImplementPaymentWithPayMobLoading());

    UserModel? userModel;

    final localResult = await userInfoCache.getUser();

    final userResult = await localResult.fold(
      (error) async {
        return null;
      },
      (localUser) async {
        if (localUser != null) return localUser;

        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) return null;

        final remoteResult = await userServices.getUserFromFirebase(
          currentUser.uid,
        );

        return remoteResult.fold((error) => null, (remoteUser) async {
          if (remoteUser != null) {
            await userInfoCache.saveUser(userModel: remoteUser);
          }
          return remoteUser;
        });
      },
    );

    if (userResult == null) {
      emit(ImplementPaymentWithPayMobFailure(errorMessage: 'User not found'));
      return; // ✅ هنا لازم تقفل التنفيذ
    }

    userModel = userResult;

    final result = await paymentRepo.paymentKeyRequest(
      currency: 'EGP',
      order: event.orderModel,
      email: userModel.email,
      name: userModel.name,
    );

    result.fold(
      (error) {
        emit(
          ImplementPaymentWithPayMobFailure(
            errorMessage: error.errorKey ?? 'Payment failed',
          ),
        );
      },
      (successUrl) {
        /// ✅ هنا الصح:
        /// مش Success
        /// لأنك لسه فتحت صفحة الدفع فقط
        emit(ImplementPaymentWithPayMobSuccess(successUrl: successUrl));
      },
    );
  }

  Future<void> _onGetPaymentStateEvent(
    GetPaymentStateEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(GetPaMobPaymentStateLoading());
    final result = await paymentRepo.getPaymentState(state: event.paymentState);
    result.fold(
      (error) {
        debugPrint('error from bloc : ${error.errorKey}=============.');
        emit(
          GetPaMobPaymentStateFailure(
            errorMessage: error.errorKey ?? 'Payment failed try again',
          ),
        );
      },
      (success) {
        if (success) {
          emit(GetPaMobPaymentStateSuccess());
        } else {
          emit(
            GetPaMobPaymentStateFailure(
              errorMessage: 'Payment failed try again',
            ),
          );
        }
      },
    );
  }
}
