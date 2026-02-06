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
      orderInfoModel: fields[3] as OrderInfoModel,
      totalPrice: fields[4] as double,
      checkoutDateAt: fields[5] as DateTime,
      orderStateEnum: fields[6] as OrderStateEnum,
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
      ..write(obj.orderInfoModel)
      ..writeByte(4)
      ..write(obj.totalPrice)
      ..writeByte(5)
      ..write(obj.checkoutDateAt)
      ..writeByte(6)
      ..write(obj.orderStateEnum);
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

class OrderStateEnumAdapter extends TypeAdapter<OrderStateEnum> {
  @override
  final int typeId = 10;

  @override
  OrderStateEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OrderStateEnum.pending;
      case 1:
        return OrderStateEnum.cancel;
      case 2:
        return OrderStateEnum.delivered;
      case 3:
        return OrderStateEnum.transmit;
      default:
        return OrderStateEnum.pending;
    }
  }

  @override
  void write(BinaryWriter writer, OrderStateEnum obj) {
    switch (obj) {
      case OrderStateEnum.pending:
        writer.writeByte(0);
        break;
      case OrderStateEnum.cancel:
        writer.writeByte(1);
        break;
      case OrderStateEnum.delivered:
        writer.writeByte(2);
        break;
      case OrderStateEnum.transmit:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStateEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
