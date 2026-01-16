import 'package:hive/hive.dart';

part 'favourite_model.g.dart';

@HiveType(typeId: 11)
class FavouriteModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String desc;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final DateTime addAt;

  FavouriteModel({
    required this.id,
    required this.title,
    required this.image,
    required this.desc,
    required this.price,
    required this.addAt,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    id: json['id'],
    title: json['title'],
    image: json['image'],
    desc: json['desc'],
    price: json['price'],
    addAt: json['addAt'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'desc': desc,
      'price': price,
      'addAt': addAt,
    };
  }

  FavouriteModel copyWith({
    String? newTitle,
    String? newDesc,
    String? newImage,
    double? newPrice,
  }) {
    return FavouriteModel(
      id: id,
      title: newTitle ?? title,
      image: newImage ?? image,
      desc: newDesc ?? desc,
      price: price,
      addAt: addAt,
    );
  }
}
