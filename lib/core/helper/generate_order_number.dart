import 'package:uuid/uuid.dart';

String generateOrderNumber() {
  const uuid = Uuid();
  //مرتب زمني وجديد وعشوئي
  String orderNumber = uuid.v7().toString();
  return orderNumber;
}
