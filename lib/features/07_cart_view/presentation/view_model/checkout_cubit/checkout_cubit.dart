import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/generate_order_number.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/delivery_method_model.dart';
import '../../../data/model/location_model.dart';
import '../../../data/model/order_model.dart';
import '../cart_bloc/cart_bloc.dart';
import '../get_cart_cubit/get_cart_cubit.dart';
import '../order_cubit/order_cubit.dart';
import '../payment_bloc/payment_bloc.dart';

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
  OrderModel? _orderModel;

  List<CartModel> _carts = [];
  double _totalPrice = 0;

  /* ========================= CART ========================= */
  void setCartData({
    required double totalPrice,
    required List<CartModel> cartList,
  }) {
    _totalPrice = totalPrice;
    _carts = cartList;

    emit(CartDataUpdatedSuccess());
    _tryBuildOrder();
  }

  /* ========================= DELIVERY ========================= */
  void chooseDeliveryMethod({
    required DeliveryMethodModel deliveryMethodModel,
  }) {
    _deliveryMethodModel = deliveryMethodModel;

    emit(ChooseDeliveryMethodDone(deliveryMethodModel: deliveryMethodModel));
    _tryBuildOrder();
  }

  /* ========================= LOCATION ========================= */
  void fillLocation({required LocationModel locationModel}) {
    _locationModel = locationModel;

    emit(FillLocationDone(locationModel: locationModel));
    _tryBuildOrder();
  }

  /* ========================= ORDER BUILD ========================= */
  void _tryBuildOrder() {
    // 🔒 بناء الـ OrderModel مرة واحدة فقط
    if (_orderModel != null) return;

    if (_deliveryMethodModel == null ||
        _locationModel == null ||
        _carts.isEmpty ||
        _totalPrice <= 0) {
      return;
    }

    _orderModel = OrderModel(
      orderId: generateOrderNumber(),
      cartModelList: _carts,
      deliveryMethodModel: _deliveryMethodModel!,
      locationModel: _locationModel!,
      totalPrice: _totalPrice,
      checkoutDateAt: DateTime.now(),
      orderStateEnum: OrderStateEnum.pending,
    );

    // emit الحالة فقط، بدون أي تنقل
    emit(OrderModelCreatedSuccess(order: _orderModel!));
  }

  /* ========================= STEPS ========================= */
  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      emit(ChangedStep(currentStep: _currentStep));
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      emit(ChangedStep(currentStep: _currentStep));
    }
  }

  void resetStep() {
    _currentStep = 0;
    _deliveryMethodModel = null;
    _locationModel = null;
    _orderModel = null;
    _carts = [];
    _totalPrice = 0;

    emit(CheckoutInitial());
  }

  /* ========================= CONFIRM ORDER ========================= */
  Future<void> confirmOrder() async {
    if (_orderModel == null) {
      emit(ConfirmOrderFailure(errorMessage: 'Order not ready'));
      return;
    }

    emit(ConfirmOrderLoading());

    await orderCubit.addOrder(orderModel: _orderModel!);
    emit(ConfirmOrderSuccess());

    cartBloc.add(DeleteAllProductsEvent());
    await getCartCubit.getCartProductsAndTotal();
  }

  Future<void> confirmOrderWithPayment(PaymentState state) async {}

  /* ========================= GETTERS ========================= */
  int get currentStep => _currentStep;

  OrderModel? get orderModel => _orderModel;

  DeliveryMethodModel? get getDeliveryMethod => _deliveryMethodModel;
}
