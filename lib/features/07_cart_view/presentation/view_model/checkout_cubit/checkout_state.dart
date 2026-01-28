part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

/* ========================= INITIAL ========================= */

final class CheckoutInitial extends CheckoutState {}

/* ========================= CART ========================= */

final class CartDataUpdatedSuccess extends CheckoutState {}

/* ========================= DELIVERY ========================= */

final class ChooseDeliveryMethodDone extends CheckoutState {
  final DeliveryMethodModel deliveryMethodModel;

  ChooseDeliveryMethodDone({required this.deliveryMethodModel});
}

/* ========================= LOCATION ========================= */

final class FillLocationDone extends CheckoutState {
  final LocationModel locationModel;

  FillLocationDone({required this.locationModel});
}

/* ========================= ORDER ========================= */

final class OrderModelCreatedSuccess extends CheckoutState {
  final OrderModel order;

  OrderModelCreatedSuccess({required this.order});
}

final class OrderReadyFailure extends CheckoutState {
  final String errorMessage;

  OrderReadyFailure({required this.errorMessage});
}

/* ========================= STEPS ========================= */

final class ChangedStep extends CheckoutState {
  final int currentStep;

  ChangedStep({required this.currentStep});
}

/* ========================= CONFIRM ORDER ========================= */

final class ConfirmOrderLoading extends CheckoutState {}

final class ConfirmOrderFailure extends CheckoutState {
  final String errorMessage;

  ConfirmOrderFailure({required this.errorMessage});
}

final class ConfirmOrderSuccess extends CheckoutState {}

/* ========================= CANCEL ========================= */

final class CancelOrder extends CheckoutState {}
