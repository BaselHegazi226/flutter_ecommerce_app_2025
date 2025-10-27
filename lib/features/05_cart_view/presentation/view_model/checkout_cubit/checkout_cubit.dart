import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/generate_order_number.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/cart_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:meta/meta.dart';

import '../../../data/model/delivery_method_model.dart';
import '../../../data/model/location_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required this.orderCubit}) : super(CheckoutInitial());
  final OrderCubit orderCubit;
  int _currentStep = 0;
  DeliveryMethodModel? _deliveryMethodModel;
  LocationModel? _locationModel;
  OrderModel? _lastOrder;
  List<CartModel> _carts = [];
  double _totalPrice = 0;
  void chooseDeliveryMethod({
    required DeliveryMethodModel deliveryMethodModel,
  }) {
    _deliveryMethodModel = deliveryMethodModel;
    emit(ChooseDeliveryMethodDone(deliveryMethodModel: deliveryMethodModel));
  }

  void fillLocation({required LocationModel locationModel}) {
    _locationModel = locationModel;
    emit(FillLocationDone(locationModel: locationModel));
  }

  void nextStep() {
    if (_currentStep < 4) {
      _currentStep++;
    }
    emit(ChangedStep(currentStep: _currentStep));
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
    }
    emit(ChangedStep(currentStep: _currentStep));
  }

  void setCartData({
    required double totalPrice,
    required List<CartModel> cartList,
  }) {
    _carts = cartList;
    _totalPrice = totalPrice;
  }

  Future<void> confirmOrder() async {
    emit(ConfirmOrderLoading());
    if (_deliveryMethodModel == null && _locationModel == null) {
      emit(ConfirmOrderFailure(errorMessage: 'Missing Order Data'));
    }
    final orderModel = OrderModel(
      orderId: generateOrderNumber(),
      cartModelList: _carts,
      deliveryMethodModel: _deliveryMethodModel!,
      locationModel: _locationModel!,
      totalPrice: _totalPrice,
      checkoutDateAt: DateTime.now(),
      orderState: OrderState.pending,
    );
    await orderCubit.addOrder(orderModel: orderModel);
    _lastOrder = orderModel;

    emit(ConfirmOrderSuccess(order: orderModel));
  }

  int get getCurrentStep {
    print('current step = $_currentStep');
    return _currentStep;
  }

  DeliveryMethodModel? get getDeliveryMethodModel => _deliveryMethodModel;
  LocationModel? get getLocationModel => _locationModel;
  OrderModel? get getOrderModel => _lastOrder;
}
