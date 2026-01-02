import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../features/04_home_view/data/model/category_model.dart';
import '../../features/05_cart_view/data/model/order_model.dart';
import '../../generated/l10n.dart';
import 'extensions_of_s_localization.dart';

const Color kPrimaryColor = Color(0xff3d9970);
const Color kPrimaryWrongColor = Colors.red;
const Color kGreyColor = Color(0xff929292);
const Color kScaffoldColor = Color(0xffFDFDFD);
const Color kScaffoldColor2 = Color(0xffefe8df);

String priceShowed(double price) {
  return price.round().toStringAsFixed(2);
}

Map<String, dynamic> orderStateData(
  BuildContext context,
  OrderStateEnum orderState,
) {
  switch (orderState) {
    case OrderStateEnum.delivered:
      return {'color': kPrimaryColor, 'state': S.of(context).orderDelivered};
    case OrderStateEnum.transmit:
      return {
        'color': Colors.yellow.shade700,
        'state': S.of(context).orderTransmit,
      };
    default:
      return {'color': kGreyColor, 'state': S.of(context).orderPending};
  }
}

starFunctionLikeGooglePlay(BuildContext context, {required double rating}) {
  return RatingBarIndicator(
    rating: rating,
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade50
          : Colors.amber,
    ),
    itemCount: 5,
    itemSize: 18,
    direction: Axis.horizontal,
  );
}

const List<CategoryModel> categories = [
  CategoryModel(
    slug: 'beauty',
    name: 'Beauty',
    image: 'https://dummyjson.com/products/category/beauty',
  ),
  CategoryModel(
    slug: 'fragrances',
    name: 'Fragrances',
    image: 'https://dummyjson.com/products/category/fragrances',
  ),
  CategoryModel(
    slug: 'furniture',
    name: 'Furniture',
    image: 'https://dummyjson.com/products/category/furniture',
  ),
  CategoryModel(
    slug: 'groceries',
    name: 'Groceries',
    image: 'https://dummyjson.com/products/category/groceries',
  ),
  CategoryModel(
    slug: 'home-decoration',
    name: 'Home Decoration',
    image: 'https://dummyjson.com/products/category/home-decoration',
  ),
  CategoryModel(
    slug: 'kitchen-accessories',
    name: 'Kitchen Accessories',
    image: 'https://dummyjson.com/products/category/kitchen-accessories',
  ),
  CategoryModel(
    slug: 'laptops',
    name: 'Laptops',
    image: 'https://dummyjson.com/products/category/laptops',
  ),
  CategoryModel(
    slug: 'mens-shirts',
    name: 'Mens Shirts',
    image: 'https://dummyjson.com/products/category/mens-shirts',
  ),
  CategoryModel(
    slug: 'mens-shoes',
    name: 'Mens Shoes',
    image: 'https://dummyjson.com/products/category/mens-shoes',
  ),
  CategoryModel(
    slug: 'mens-watches',
    name: 'Mens Watches',
    image: 'https://dummyjson.com/products/category/mens-watches',
  ),
  CategoryModel(
    slug: 'mobile-accessories',
    name: 'Mobile Accessories',
    image: 'https://dummyjson.com/products/category/mobile-accessories',
  ),
  CategoryModel(
    slug: 'motorcycle',
    name: 'Motorcycle',
    image: 'https://dummyjson.com/products/category/motorcycle',
  ),
  CategoryModel(
    slug: 'skin-care',
    name: 'Skin Care',
    image: 'https://dummyjson.com/products/category/skin-care',
  ),
  CategoryModel(
    slug: 'smartphones',
    name: 'Smartphones',
    image: 'https://dummyjson.com/products/category/smartphones',
  ),
  CategoryModel(
    slug: 'sports-accessories',
    name: 'Sports Accessories',
    image: 'https://dummyjson.com/products/category/sports-accessories',
  ),
  CategoryModel(
    slug: 'sunglasses',
    name: 'Sunglasses',
    image: 'https://dummyjson.com/products/category/sunglasses',
  ),
  CategoryModel(
    slug: 'tablets',
    name: 'Tablets',
    image: 'https://dummyjson.com/products/category/tablets',
  ),
  CategoryModel(
    slug: 'tops',
    name: 'Tops',
    image: 'https://dummyjson.com/products/category/tops',
  ),
  CategoryModel(
    slug: 'vehicle',
    name: 'Vehicle',
    image: 'https://dummyjson.com/products/category/vehicle',
  ),
  CategoryModel(
    slug: 'womens-bags',
    name: 'Womens Bags',
    image: 'https://dummyjson.com/products/category/womens-bags',
  ),
  CategoryModel(
    slug: 'womens-dresses',
    name: 'Womens Dresses',
    image: 'https://dummyjson.com/products/category/womens-dresses',
  ),
  CategoryModel(
    slug: 'womens-jewellery',
    name: 'Womens Jewellery',
    image: 'https://dummyjson.com/products/category/womens-jewellery',
  ),
  CategoryModel(
    slug: 'womens-shoes',
    name: 'Womens Shoes',
    image: 'https://dummyjson.com/products/category/womens-shoes',
  ),
  CategoryModel(
    slug: 'womens-watches',
    name: 'Womens Watches',
    image: 'https://dummyjson.com/products/category/womens-watches',
  ),
];

String? searchFilter(String input) {
  final query = input.toLowerCase().trim();

  if (query.isEmpty) return null;

  // 1️⃣ match مباشر في slug
  for (final category in categories) {
    if (category.slug.contains(query)) {
      return category.slug;
    }
  }

  // 2️⃣ match في الاسم
  for (final category in categories) {
    if (category.name.toLowerCase().contains(query)) {
      return category.slug;
    }
  }

  // 3️⃣ match جزئي (fuzzy)
  for (final category in categories) {
    final slugParts = category.slug.split('-');
    if (slugParts.any((part) => part.contains(query))) {
      return category.slug;
    }
  }

  return null;
}
