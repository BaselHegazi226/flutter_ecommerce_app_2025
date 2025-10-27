// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 7;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      orderId: fields[0] as String,
      cartModelList: (fields[1] as List).cast<CartModel>(),
      deliveryMethodModel: fields[2] as DeliveryMethodModel,
      locationModel: fields[3] as LocationModel,
      totalPrice: fields[4] as double,
      checkoutDateAt: fields[5] as DateTime,
      orderState: fields[6] as OrderState,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.cartModelList)
      ..writeByte(2)
      ..write(obj.deliveryMethodModel)
      ..writeByte(3)
      ..write(obj.locationModel)
      ..writeByte(4)
      ..write(obj.totalPrice)
      ..writeByte(5)
      ..write(obj.checkoutDateAt)
      ..writeByte(6)
      ..write(obj.orderState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
