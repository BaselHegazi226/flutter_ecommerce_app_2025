part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class ImplementPaymentWithPayMobEvent extends PaymentEvent {
  final OrderModel orderModel;

  ImplementPaymentWithPayMobEvent({required this.orderModel});
}

class GetPaymentStateEvent extends PaymentEvent {
  final bool paymentState;

  GetPaymentStateEvent({required this.paymentState});
}
