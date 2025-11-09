import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/generate_order_number.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/cart_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';

import '../../../data/model/delivery_method_model.dart';
import '../../../data/model/location_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.orderCubit,
    required this.cartBloc,
    required this.getCartCubit,
  }) : super(CheckoutInitial());
  final OrderCubit orderCubit;
  final CartBloc cartBloc;
  final GetCartCubit getCartCubit;
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
    debugPrint('current Step = $_currentStep');
    emit(ChangedStep(currentStep: _currentStep));
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
    }
    debugPrint('current Step = $_currentStep');
    emit(ChangedStep(currentStep: _currentStep));
  }

  void resetStep() {
    _lastOrder = null;
    _currentStep = 0;
    _locationModel = null;
    _deliveryMethodModel = const DeliveryMethodModel(
      title: 'Next Day Delivery',
      subtitle:
          'Place your order before 6pm and your items will be delivered the next day',
    );
    _carts = [];
    _totalPrice = 0;

    emit(CheckoutInitial());
  }

  void setCartData({
    required double totalPrice,
    required List<CartModel> cartList,
  }) {
    _carts = cartList;
    _totalPrice = totalPrice;
  }

  Future<void> orderReady() async {
    emit(OrderReadyLoading());
    if (_locationModel != null && _deliveryMethodModel != null) {
      final orderModel = OrderModel(
        orderId: generateOrderNumber(),
        cartModelList: _carts,
        deliveryMethodModel: _deliveryMethodModel!,
        locationModel: _locationModel!,
        totalPrice: _totalPrice,
        checkoutDateAt: DateTime.now(),
        orderStateEnum: OrderStateEnum.pending,
      );
      _lastOrder = orderModel;
    }
    if (_lastOrder != null) {
      emit(OrderReadySuccess(order: _lastOrder!));
    } else {
      emit(OrderReadyFailure(errorMessage: 'Order Not Ready'));
    }
  }

  Future<void> confirmOrder() async {
    emit(ConfirmOrderLoading());
    if (_lastOrder == null) {
      debugPrint('delivery model = ${_deliveryMethodModel?.toJson()}');
      debugPrint('location model = ${_locationModel?.toJson()}');
      debugPrint('order confirm failure===============================>');
      emit(ConfirmOrderFailure(errorMessage: 'Missing Order Data'));
    } else {
      debugPrint('delivery model = ${_deliveryMethodModel?.toJson()}');
      debugPrint('location model = ${_locationModel?.toJson()}');

      await orderCubit.addOrder(orderModel: _lastOrder!);
      emit(ConfirmOrderSuccess());
      debugPrint('order confirm success===============================>');
      cartBloc.add(DeleteAllProductsEvent());
      //tigger the cart
      await getCartCubit.getCartProductsAndTotal();
      debugPrint('cart is deleted success===============================>');
    }
  }

  int get getCurrentStep {
    return _currentStep;
  }

  DeliveryMethodModel? get getDeliveryMethodModel => _deliveryMethodModel;
  LocationModel? get getLocationModel => _locationModel;
  OrderModel? get getOrderModel => _lastOrder;
}
