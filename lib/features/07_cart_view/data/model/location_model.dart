import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 9)
class OrderInfoModel {
  @HiveField(0)
  final LocationModel? locationModel;
  @HiveField(1)
  final String? phoneNumber;

  const OrderInfoModel({
    required this.locationModel,
    required this.phoneNumber,
  });

  factory OrderInfoModel.fromJson(json) {
    return OrderInfoModel(
      locationModel: json['locationModel'],
      phoneNumber: json['phoneNumber'],
    );
  }

  toJson() {
    return {'locationModel': locationModel, 'phoneNumber': phoneNumber};
  }
}

@HiveType(typeId: 13)
class LocationModel {
  @HiveField(0)
  final String street1;
  @HiveField(1)
  final String street2;
  @HiveField(2)
  final String city;
  @HiveField(3)
  final String state;
  @HiveField(4)
  final String country;

  const LocationModel({
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.country,
  });

  factory LocationModel.fromJson(json) {
    return LocationModel(
      street1: json['street1'],
      street2: json['street2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  toJson() {
    return {
      'street1': street1,
      'street2': street2,
      'city': city,
      'state': state,
      'country': country,
    };
  }
}
