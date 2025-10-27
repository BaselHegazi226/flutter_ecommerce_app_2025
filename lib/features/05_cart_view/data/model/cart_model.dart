import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int productCount;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final DateTime addAt;
  const CartModel({
    this.productCount = 1,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.addAt,
  });

  factory CartModel.fromJson(jsonData) {
    return CartModel(
      id: jsonData['id'],
      imageUrl: jsonData['imageUrl'],
      title: jsonData['title'],
      price: jsonData['price'],
      productCount: jsonData['productCount'],
      addAt: DateTime.now(),
    );
  }

  CartModel copyWith({
    int? newId,
    String? newTitle,
    double? newPrice,
    String? newImageUrl,
    int? newCount,
  }) {
    return CartModel(
      id: newId ?? id,
      title: newTitle ?? title,
      price: newPrice ?? price,
      imageUrl: newImageUrl ?? imageUrl,
      productCount: newCount ?? productCount,
      addAt: addAt,
    );
  }

  toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
      'productCount': productCount,
    };
  }
}
