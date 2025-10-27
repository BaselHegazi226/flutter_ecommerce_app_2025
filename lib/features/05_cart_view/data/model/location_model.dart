import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 9)
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
}
