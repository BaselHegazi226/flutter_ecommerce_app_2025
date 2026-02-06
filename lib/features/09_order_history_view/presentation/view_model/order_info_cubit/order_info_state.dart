part of 'order_info_cubit.dart';

@immutable
sealed class OrderInfoState {}

final class OrderInfoInitial extends OrderInfoState {}

final class SaveHistoryHistoryOrderInfoInitial extends OrderInfoState {}

final class SaveHistoryOrderInfoLoading extends OrderInfoState {}

final class SaveHistoryOrderInfoSuccess extends OrderInfoState {}

final class SaveHistoryOrderInfoFailure extends OrderInfoState {
  final String errorMessage;

  SaveHistoryOrderInfoFailure({required this.errorMessage});
}

final class GetOrderHistoryInfoInitial extends OrderInfoState {}

final class GetOrderHistoryInfoLoading extends OrderInfoState {}

final class GetOrderHistoryInfoSuccess extends OrderInfoState {
  final OrderInfoModel orderInfoModel;

  GetOrderHistoryInfoSuccess({required this.orderInfoModel});
}

final class GetOrderHistoryInfoFailure extends OrderInfoState {
  final String errorMessage;

  GetOrderHistoryInfoFailure({required this.errorMessage});
}
