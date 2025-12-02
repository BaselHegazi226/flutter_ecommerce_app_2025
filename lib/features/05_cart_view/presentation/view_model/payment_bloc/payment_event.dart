part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class ImplementPaymentWithPayMobEvent extends PaymentEvent {
  final PaymentModel paymentModel;
  final bool isDark;
  ImplementPaymentWithPayMobEvent({
    required this.paymentModel,
    required this.isDark,
  });
}
