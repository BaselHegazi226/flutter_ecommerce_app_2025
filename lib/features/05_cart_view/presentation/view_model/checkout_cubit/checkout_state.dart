part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class ChooseDeliveryMethodDone extends CheckoutState {
  final DeliveryMethodModel deliveryMethodModel;

  ChooseDeliveryMethodDone({required this.deliveryMethodModel});
}

final class FillLocationDone extends CheckoutState {
  final LocationModel locationModel;
  FillLocationDone({required this.locationModel});
}

final class ChangedStep extends CheckoutState {
  final int currentStep;

  ChangedStep({required this.currentStep});
}

//order states
final class ConfirmOrderLoading extends CheckoutState {}

final class ConfirmOrderFailure extends CheckoutState {
  final String errorMessage;

  ConfirmOrderFailure({required this.errorMessage});
}

final class ConfirmOrderSuccess extends CheckoutState {
  final OrderModel order;

  ConfirmOrderSuccess({required this.order});
}

final class CancelOrder extends CheckoutState {}
