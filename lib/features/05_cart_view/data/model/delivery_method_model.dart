import 'package:hive/hive.dart';

part 'delivery_method_model.g.dart';

@HiveType(typeId: 8)
class DeliveryMethodModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  const DeliveryMethodModel({required this.title, required this.subtitle});
}
