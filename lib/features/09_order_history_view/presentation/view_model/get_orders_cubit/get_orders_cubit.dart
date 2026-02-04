import 'package:bloc/bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:meta/meta.dart';

import '../../../../07_cart_view/data/model/order_model.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit({required this.orderCache}) : super(GetOrdersInitial());
  final OrderCache orderCache;

  Future<void> getOrderList() async {
    emit(GetOrdersLoading());
    final result = await orderCache.getOrderList();
    result.fold(
      (error) {
        emit(GetOrdersFailure(errorMessage: error.errorKey ?? 'unknown error'));
      },
      (successOrders) async {
        List<OrderModel> updatedOrders = [];

        for (var item in successOrders) {
          final orderAfterGetState = await orderCache.getOrderState(
            orderModel: item,
          );

          orderAfterGetState.fold(
            (error) {
              // هنا الأفضل تحتفظ بالأوردر الأصلي لو فشل التحديث
              updatedOrders.add(item);
            },
            (success) {
              updatedOrders.add(success);
            },
          );
        }

        // بعد ما تخلص كله، اعرض النتيجة النهائية مرة واحدة
        emit(GetOrdersSuccess(orders: updatedOrders));
      },
    );
  }
}
