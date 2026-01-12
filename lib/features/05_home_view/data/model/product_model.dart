import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class ProductModel {
  ProductModel({
    required this.images,
    required this.thumbnail,
    required this.minimumOrderQuantity,
    required this.rating,
    required this.returnPolicy,
    required this.description,
    required this.weight,
    required this.warrantyInformation,
    required this.title,
    required this.tags,
    required this.discountPercentage,
    required this.reviews,
    required this.price,
    required this.meta,
    required this.shippingInformation,
    required this.id,
    required this.availabilityStatus,
    required this.category,
    required this.stock,
    required this.sku,
    required this.dimensions,
  });
  @HiveField(0)
  List<String> images;
  @HiveField(1)
  String thumbnail;
  @HiveField(2)
  int minimumOrderQuantity;
  @HiveField(3)
  double rating;
  @HiveField(4)
  String returnPolicy;
  @HiveField(5)
  String description;
  @HiveField(6)
  int weight;
  @HiveField(7)
  String warrantyInformation;
  @HiveField(8)
  String title;
  @HiveField(9)
  List<String> tags;
  @HiveField(10)
  double discountPercentage;
  @HiveField(11)
  List<Review> reviews;
  @HiveField(12)
  double price;
  @HiveField(13)
  Meta meta;
  @HiveField(14)
  String shippingInformation;
  @HiveField(15)
  int id;
  @HiveField(16)
  String availabilityStatus;
  @HiveField(17)
  String category;
  @HiveField(18)
  int stock;
  @HiveField(19)
  String sku;
  @HiveField(20)
  Dimensions dimensions;

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) => ProductModel(
    images: List<String>.from(json["images"].map((x) => x)),
    thumbnail: json["thumbnail"],
    minimumOrderQuantity: json["minimumOrderQuantity"],
    rating: json["rating"]?.toDouble(),
    returnPolicy: json["returnPolicy"],
    description: json["description"],
    weight: json["weight"],
    warrantyInformation: json["warrantyInformation"],
    title: json["title"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    discountPercentage: json["discountPercentage"]?.toDouble(),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    price: json["price"]?.toDouble(),
    meta: Meta.fromJson(json["meta"]),
    shippingInformation: json["shippingInformation"],
    id: json["id"],
    availabilityStatus: json["availabilityStatus"],
    category: json["category"],
    stock: json["stock"],
    sku: json["sku"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x)),
    "thumbnail": thumbnail,
    "minimumOrderQuantity": minimumOrderQuantity,
    "rating": rating,
    "returnPolicy": returnPolicy,
    "description": description,
    "weight": weight,
    "warrantyInformation": warrantyInformation,
    "title": title,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "discountPercentage": discountPercentage,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "price": price,
    "meta": meta.toJson(),
    "shippingInformation": shippingInformation,
    "id": id,
    "availabilityStatus": availabilityStatus,
    "category": category,
    "stock": stock,
    "sku": sku,
    "dimensions": dimensions.toJson(),
  };
}

@HiveType(typeId: 3)
class Dimensions {
  Dimensions({required this.depth, required this.width, required this.height});
  @HiveField(0)
  double depth;
  @HiveField(1)
  double width;
  @HiveField(2)
  double height;

  factory Dimensions.fromJson(Map<dynamic, dynamic> json) => Dimensions(
    depth: json["depth"]?.toDouble(),
    width: json["width"]?.toDouble(),
    height: json["height"]?.toDouble(),
  );

  Map<dynamic, dynamic> toJson() => {
    "depth": depth,
    "width": width,
    "height": height,
  };
}

@HiveType(typeId: 4)
class Meta {
  Meta({
    required this.createdAt,
    required this.qrCode,
    required this.barcode,
    required this.updatedAt,
  });
  @HiveField(0)
  DateTime createdAt;
  @HiveField(1)
  String qrCode;
  @HiveField(2)
  String barcode;
  @HiveField(3)
  DateTime updatedAt;

  factory Meta.fromJson(Map<dynamic, dynamic> json) => Meta(
    createdAt: DateTime.parse(json["createdAt"]),
    qrCode: json["qrCode"],
    barcode: json["barcode"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "qrCode": qrCode,
    "barcode": barcode,
    "updatedAt": updatedAt.toIso8601String(),
  };
}

@HiveType(typeId: 5)
class Review {
  Review({
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
    required this.rating,
    required this.comment,
  });
  @HiveField(0)
  DateTime date;
  @HiveField(1)
  String reviewerName;
  @HiveField(2)
  String reviewerEmail;
  @HiveField(3)
  int rating;
  @HiveField(4)
  String comment;

  factory Review.fromJson(Map<dynamic, dynamic> json) => Review(
    date: DateTime.parse(json["date"]),
    reviewerName: json["reviewerName"],
    reviewerEmail: json["reviewerEmail"],
    rating: json["rating"],
    comment: json["comment"],
  );

  Map<dynamic, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "reviewerName": reviewerName,
    "reviewerEmail": reviewerEmail,
    "rating": rating,
    "comment": comment,
  };
}

extension ProductModelCopyWith on ProductModel {
  ProductModel copyWith({
    List<String>? images,
    String? thumbnail,
    int? minimumOrderQuantity,
    double? rating,
    String? returnPolicy,
    String? description,
    int? weight,
    String? warrantyInformation,
    String? title,
    List<String>? tags,
    double? discountPercentage,
    List<Review>? reviews,
    double? price,
    Meta? meta,
    String? shippingInformation,
    int? id,
    String? availabilityStatus,
    String? category,
    int? stock,
    String? sku,
    Dimensions? dimensions,
  }) {
    return ProductModel(
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      rating: rating ?? this.rating,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      title: title ?? this.title,
      tags: tags ?? this.tags,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      meta: meta ?? this.meta,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      id: id ?? this.id,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      sku: sku ?? this.sku,
      dimensions: dimensions ?? this.dimensions,
    );
  }
}
