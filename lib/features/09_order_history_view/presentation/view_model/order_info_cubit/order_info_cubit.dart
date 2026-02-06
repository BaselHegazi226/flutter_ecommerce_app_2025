import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/cache/order_cache.dart';
import '../../../../07_cart_view/data/model/location_model.dart';

part 'order_info_state.dart';

class OrderInfoCubit extends Cubit<OrderInfoState> {
  OrderInfoCubit({required this.orderCache}) : super(OrderInfoInitial());
  OrderCache orderCache;

  Future<void> getOrderHistoryInfo() async {
    emit(GetOrderHistoryInfoLoading());
    final result = await orderCache.getOrderInfo();
    result.fold(
      (error) {
        emit(
          GetOrderHistoryInfoFailure(errorMessage: error.errorKey ?? 'unknown'),
        );
      },
      (success) {
        if (success != null) {
          emit(GetOrderHistoryInfoSuccess(orderInfoModel: success));
        } else {
          emit(
            GetOrderHistoryInfoFailure(errorMessage: 'Not Found User Location'),
          );
        }
      },
    );
  }

  Future<void> saveOrderHistoryInfo({
    required OrderInfoModel orderInfoModel,
  }) async {
    emit(SaveHistoryOrderInfoLoading());
    final result = await orderCache.saveOrderInfo(
      orderInfoModel: orderInfoModel,
    );
    result.fold(
      (error) {
        emit(
          SaveHistoryOrderInfoFailure(
            errorMessage: error.errorKey ?? 'unknown',
          ),
        );
      },
      (success) {
        emit(SaveHistoryOrderInfoSuccess());
      },
    );
  }
}
