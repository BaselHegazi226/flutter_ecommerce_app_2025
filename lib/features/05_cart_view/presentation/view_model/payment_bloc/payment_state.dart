part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class ImplementPaymentWithPayMobInitial extends PaymentState {}

final class ImplementPaymentWithPayMobLoading extends PaymentState {}

final class ImplementPaymentWithPayMobFailure extends PaymentState {
  final String errorMessage;

  ImplementPaymentWithPayMobFailure({required this.errorMessage});
}

final class ImplementPaymentWithPayMobSuccess extends PaymentState {}
