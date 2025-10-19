// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 2;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      images: (fields[0] as List).cast<String>(),
      thumbnail: fields[1] as String,
      minimumOrderQuantity: fields[2] as int,
      rating: fields[3] as double,
      returnPolicy: fields[4] as String,
      description: fields[5] as String,
      weight: fields[6] as int,
      warrantyInformation: fields[7] as String,
      title: fields[8] as String,
      tags: (fields[9] as List).cast<String>(),
      discountPercentage: fields[10] as double,
      reviews: (fields[11] as List).cast<Review>(),
      price: fields[12] as double,
      meta: fields[13] as Meta,
      shippingInformation: fields[14] as String,
      id: fields[15] as int,
      availabilityStatus: fields[16] as String,
      category: fields[17] as String,
      stock: fields[18] as int,
      sku: fields[19] as String,
      dimensions: fields[20] as Dimensions,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.images)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.minimumOrderQuantity)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.returnPolicy)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.warrantyInformation)
      ..writeByte(8)
      ..write(obj.title)
      ..writeByte(9)
      ..write(obj.tags)
      ..writeByte(10)
      ..write(obj.discountPercentage)
      ..writeByte(11)
      ..write(obj.reviews)
      ..writeByte(12)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.meta)
      ..writeByte(14)
      ..write(obj.shippingInformation)
      ..writeByte(15)
      ..write(obj.id)
      ..writeByte(16)
      ..write(obj.availabilityStatus)
      ..writeByte(17)
      ..write(obj.category)
      ..writeByte(18)
      ..write(obj.stock)
      ..writeByte(19)
      ..write(obj.sku)
      ..writeByte(20)
      ..write(obj.dimensions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DimensionsAdapter extends TypeAdapter<Dimensions> {
  @override
  final int typeId = 3;

  @override
  Dimensions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dimensions(
      depth: fields[0] as double,
      width: fields[1] as double,
      height: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Dimensions obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.depth)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DimensionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetaAdapter extends TypeAdapter<Meta> {
  @override
  final int typeId = 4;

  @override
  Meta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meta(
      createdAt: fields[0] as DateTime,
      qrCode: fields[1] as String,
      barcode: fields[2] as String,
      updatedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Meta obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.qrCode)
      ..writeByte(2)
      ..write(obj.barcode)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReviewAdapter extends TypeAdapter<Review> {
  @override
  final int typeId = 5;

  @override
  Review read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Review(
      date: fields[0] as DateTime,
      reviewerName: fields[1] as String,
      reviewerEmail: fields[2] as String,
      rating: fields[3] as int,
      comment: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Review obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.reviewerName)
      ..writeByte(2)
      ..write(obj.reviewerEmail)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
