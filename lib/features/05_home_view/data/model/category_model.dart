class CategoryModel {
  final String slug;
  final String name;
  final String requestForCategoryUrl;

  const CategoryModel({
    required this.slug,
    required this.name,
    required this.requestForCategoryUrl,
  });

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      requestForCategoryUrl: json['url'],
    );
  }

  toJson() {
    return {'slug': slug, 'name': name, 'image': requestForCategoryUrl};
  }
}
