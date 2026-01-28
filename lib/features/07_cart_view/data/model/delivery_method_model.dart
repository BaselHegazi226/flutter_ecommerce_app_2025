import 'package:hive/hive.dart';

part 'delivery_method_model.g.dart';

@HiveType(typeId: 8)
class DeliveryMethodModel {
  @HiveField(0)
  final DeliveryType deliveryType;

  @HiveField(1)
  final DateTime? selectedTime;

  const DeliveryMethodModel({required this.deliveryType, this.selectedTime});

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    return DeliveryMethodModel(
      deliveryType: DeliveryType.values.firstWhere(
        (e) => e.name == json['deliveryType'],
      ),
      selectedTime: json['selectedTime'] != null
          ? DateTime.parse(json['selectedTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deliveryType': deliveryType.name, // ENGLISH ONLY
      'selectedTime': selectedTime?.toIso8601String(),
    };
  }
}

@HiveType(typeId: 12)
enum DeliveryType {
  @HiveField(0)
  standard,
  @HiveField(1)
  nextDay,
  @HiveField(2)
  nominated,
}
