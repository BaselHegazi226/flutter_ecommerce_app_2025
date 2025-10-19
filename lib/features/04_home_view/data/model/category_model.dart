class CategoryModel {
  final String slug;
  final String name;
  final String image;
  const CategoryModel({
    required this.slug,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      image: json['url'],
    );
  }
  toJson() {
    return {'slug': slug, 'name': name, 'image': image};
  }
}
