// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_method_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryMethodModelAdapter extends TypeAdapter<DeliveryMethodModel> {
  @override
  final int typeId = 8;

  @override
  DeliveryMethodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryMethodModel(
      deliveryType: fields[0] as DeliveryType,
      selectedTime: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryMethodModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.deliveryType)
      ..writeByte(1)
      ..write(obj.selectedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryMethodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeliveryTypeAdapter extends TypeAdapter<DeliveryType> {
  @override
  final int typeId = 12;

  @override
  DeliveryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeliveryType.standard;
      case 1:
        return DeliveryType.nextDay;
      case 2:
        return DeliveryType.nominated;
      default:
        return DeliveryType.standard;
    }
  }

  @override
  void write(BinaryWriter writer, DeliveryType obj) {
    switch (obj) {
      case DeliveryType.standard:
        writer.writeByte(0);
        break;
      case DeliveryType.nextDay:
        writer.writeByte(1);
        break;
      case DeliveryType.nominated:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
