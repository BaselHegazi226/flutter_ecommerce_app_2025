// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderInfoModelAdapter extends TypeAdapter<OrderInfoModel> {
  @override
  final int typeId = 9;

  @override
  OrderInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderInfoModel(
      locationModel: fields[0] as LocationModel?,
      phoneNumber: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderInfoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.locationModel)
      ..writeByte(1)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationModelAdapter extends TypeAdapter<LocationModel> {
  @override
  final int typeId = 13;

  @override
  LocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModel(
      street1: fields[0] as String,
      street2: fields[1] as String,
      city: fields[2] as String,
      state: fields[3] as String,
      country: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.street1)
      ..writeByte(1)
      ..write(obj.street2)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
