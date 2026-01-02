import 'package:dio/dio.dart';

class PaymentServices {
  Dio dio = Dio();
  final baseUrl = 'https://accept.paymob.com/v1';
  Future<dynamic> paymentIntention({
    required String endPoint,
    required dynamic body,
    required Options options,
  }) async {
    final response = await dio.post(
      '$baseUrl/$endPoint',
      options: options,
      data: body,
    );
    return response;
  }
}
