import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../features/05_home_view/data/model/category_model.dart';
import '../../features/07_cart_view/data/model/order_model.dart';
import '../../generated/l10n.dart';
import '../utilities/extensions_of_s_localization.dart';

const Color kPrimaryColor = Color(0xff3d9970);
const Color kPrimaryWrongColor = Colors.red;
const Color kGreyColor = Color(0xff929292);
const Color kScaffoldColor = Color(0xffFDFDFD);
const Color kScaffoldColor2 = Color(0xffefe8df);

final Color kCheckoutStepperFinishedColorDark = Colors.grey.shade400;
final Color kCheckoutStepperFinishedColorLight = const Color(
  0xff3d9970,
).withAlpha(125);

final Color kCheckoutStepperActiveColorDark = Colors.grey.shade200;
const Color kCheckoutStepperActiveColorLight = Color(0xff3d9970);

final Color kCheckoutStepperUnreachedColorDark = Colors.grey.shade500;
final Color kCheckoutStepperUnreachedColorLight = Colors.grey.shade400;

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

const Map<String, String> categoryArabicNames = {
  'beauty': 'الجمال',
  'fragrances': 'العطور',
  'furniture': 'الأثاث',
  'groceries': 'البقالة',
  'home-decoration': 'ديكور المنزل',
  'kitchen-accessories': 'مستلزمات المطبخ',
  'laptops': 'أجهزة لابتوب',
  'mens-shirts': 'قمصان رجالي',
  'mens-shoes': 'أحذية رجالي',
  'mens-watches': 'ساعات رجالي',
  'mobile-accessories': 'إكسسوارات الموبايل',
  'motorcycle': 'دراجات نارية',
  'skin-care': 'العناية بالبشرة',
  'smartphones': 'هواتف ذكية',
  'sports-accessories': 'مستلزمات رياضية',
  'sunglasses': 'نظارات شمس',
  'tablets': 'أجهزة لوحية',
  'tops': 'ملابس علوية',
  'vehicle': 'مركبات',
  'womens-bags': 'حقائب نسائية',
  'womens-dresses': 'فساتين نسائية',
  'womens-jewellery': 'مجوهرات نسائية',
  'womens-shoes': 'أحذية نسائية',
  'womens-watches': 'ساعات نسائية',
};

const List<CategoryModel> categories = [
  CategoryModel(
    slug: 'beauty',
    name: 'الجمال',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/beauty',
  ),
  CategoryModel(
    slug: 'fragrances',
    name: 'العطور',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/fragrances',
  ),
  CategoryModel(
    slug: 'furniture',
    name: 'الأثاث',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/furniture',
  ),
  CategoryModel(
    slug: 'groceries',
    name: 'البقالة',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/groceries',
  ),
  CategoryModel(
    slug: 'home-decoration',
    name: 'ديكور المنزل',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/home-decoration',
  ),
  CategoryModel(
    slug: 'kitchen-accessories',
    name: 'مستلزمات المطبخ',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/kitchen-accessories',
  ),
  CategoryModel(
    slug: 'laptops',
    name: 'أجهزة لابتوب',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/laptops',
  ),
  CategoryModel(
    slug: 'mens-shirts',
    name: 'قمصان رجالي',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/mens-shirts',
  ),
  CategoryModel(
    slug: 'mens-shoes',
    name: 'أحذية رجالي',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/mens-shoes',
  ),
  CategoryModel(
    slug: 'mens-watches',
    name: 'ساعات رجالي',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/mens-watches',
  ),
  CategoryModel(
    slug: 'mobile-accessories',
    name: 'إكسسوارات الموبايل',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/mobile-accessories',
  ),
  CategoryModel(
    slug: 'motorcycle',
    name: 'دراجات نارية',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/motorcycle',
  ),
  CategoryModel(
    slug: 'skin-care',
    name: 'العناية بالبشرة',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/skin-care',
  ),
  CategoryModel(
    slug: 'smartphones',
    name: 'هواتف ذكية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/smartphones',
  ),
  CategoryModel(
    slug: 'sports-accessories',
    name: 'مستلزمات رياضية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/sports-accessories',
  ),
  CategoryModel(
    slug: 'sunglasses',
    name: 'نظارات شمس',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/sunglasses',
  ),
  CategoryModel(
    slug: 'tablets',
    name: 'أجهزة لوحية',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/tablets',
  ),
  CategoryModel(
    slug: 'tops',
    name: 'ملابس علوية',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/tops',
  ),
  CategoryModel(
    slug: 'vehicle',
    name: 'مركبات',
    requestForCategoryUrl: 'https://dummyjson.com/products/category/vehicle',
  ),
  CategoryModel(
    slug: 'womens-bags',
    name: 'حقائب نسائية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/womens-bags',
  ),
  CategoryModel(
    slug: 'womens-dresses',
    name: 'فساتين نسائية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/womens-dresses',
  ),
  CategoryModel(
    slug: 'womens-jewellery',
    name: 'مجوهرات نسائية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/womens-jewellery',
  ),
  CategoryModel(
    slug: 'womens-shoes',
    name: 'أحذية نسائية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/womens-shoes',
  ),
  CategoryModel(
    slug: 'womens-watches',
    name: 'ساعات نسائية',
    requestForCategoryUrl:
        'https://dummyjson.com/products/category/womens-watches',
  ),
];

String normalizeArabic(String text) {
  return text
      .toLowerCase()
      .trim()
      .replaceAll('أ', 'ا')
      .replaceAll('إ', 'ا')
      .replaceAll('آ', 'ا')
      .replaceAll('ى', 'ي')
      .replaceAll('ة', 'ه');
}

String? searchFilter(String input) {
  final query = normalizeArabic(input);

  if (query.isEmpty) return null;

  for (final category in categories) {
    final arabicName = normalizeArabic(category.getArabicCategoryName);
    final englishName = category.name.toLowerCase();

    if (arabicName.contains(query) ||
        englishName.contains(query) ||
        category.slug.contains(query)) {
      return category.slug;
    }
  }

  return null;
}
