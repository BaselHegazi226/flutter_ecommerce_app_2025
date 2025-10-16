import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';

enum CategoryIcon {
  beauty(Mdi.lipstick, Color(0xFFFF69B4)), // وردي جمالي
  fragrances(Fa6Solid.spray_can_sparkles, Color(0xFFB19CD9)), // بنفسجي عطري
  furniture(MaterialSymbols.table_bar_rounded, Color(0xFF8B4513)), // بني خشبي
  groceries(Mdi.shopping_outline, Color(0xFF3CB371)), // أخضر طازج
  homeDecoration(Ion.color_palette, Color(0xFFFFA500)), // برتقالي ديكوري
  kitchenAccessories(Mdi.pot_mix, Color(0xFFD2691E)), // نحاسي مطبخي
  laptops(Mdi.laptop, Color(0xFF1976D2)), // أزرق تقني
  mensShirts(Mdi.tshirt_crew, Color(0xFF1E88E5)), // أزرق أزياء رجالية
  mensShoes(Mdi.shoe_sneaker, Color(0xFF4E342E)), // بني جلد
  mensWatches(Mdi.watch_variant, Color(0xFF607D8B)), // رمادي معدني
  mobileAccessories(Mdi.cellphone_cog, Color(0xFF0288D1)), // أزرق سماوي
  motorcycle(Mdi.motorbike, Color(0xFF212121)), // أسود قوي
  skinCare(Mdi.face_woman_shimmer, Color(0xFFFFC0CB)), // وردي ناعم للبشرة
  smartphones(Mdi.cellphone, Color(0xFF00796B)), // أخضر داكن عصري
  sportsAccessories(Mdi.soccer, Color(0xFF43A047)), // أخضر طاقة
  sunglasses(Mdi.sunglasses, Color(0xFF000000)), // أسود كلاسيكي
  tablets(Mdi.tablet, Color(0xFF00BCD4)), // سماوي حديث
  tops(Mdi.hanger, Color(0xFFFF7043)), // برتقالي موضة
  vehicle(Mdi.car, Color(0xFF455A64)), // رمادي معدني
  womensBags(Bi.handbag_fill, Color(0xFFD81B60)), // وردي فخم
  womensDresses(Mdi.hanger, Color(0xFFEC407A)), // وردي زاهي
  womensJewellery(Mdi.diamond_stone, Color(0xFFFFD700)), // ذهبي مجوهرات
  womensShoes(Mdi.shoe_heel, Color(0xFFE91E63)), // وردي أنثوي
  womensWatches(Mdi.watch, Color(0xFF9C27B0)); // بنفسجي أنيق

  final String iconName;
  final Color color;

  const CategoryIcon(this.iconName, this.color);

  static Widget fromSlug(
    BuildContext context,
    String slug, {
    double size = 24,
  }) {
    final map = {
      'beauty': CategoryIcon.beauty,
      'fragrances': CategoryIcon.fragrances,
      'furniture': CategoryIcon.furniture,
      'groceries': CategoryIcon.groceries,
      'home-decoration': CategoryIcon.homeDecoration,
      'kitchen-accessories': CategoryIcon.kitchenAccessories,
      'laptops': CategoryIcon.laptops,
      'mens-shirts': CategoryIcon.mensShirts,
      'mens-shoes': CategoryIcon.mensShoes,
      'mens-watches': CategoryIcon.mensWatches,
      'mobile-accessories': CategoryIcon.mobileAccessories,
      'motorcycle': CategoryIcon.motorcycle,
      'skin-care': CategoryIcon.skinCare,
      'smartphones': CategoryIcon.smartphones,
      'sports-accessories': CategoryIcon.sportsAccessories,
      'sunglasses': CategoryIcon.sunglasses,
      'tablets': CategoryIcon.tablets,
      'tops': CategoryIcon.tops,
      'vehicle': CategoryIcon.vehicle,
      'womens-bags': CategoryIcon.womensBags,
      'womens-dresses': CategoryIcon.womensDresses,
      'womens-jewellery': CategoryIcon.womensJewellery,
      'womens-shoes': CategoryIcon.womensShoes,
      'womens-watches': CategoryIcon.womensWatches,
    };

    final category = map[slug];
    if (category == null) {
      return Iconify(Mdi.tag, size: size, color: Colors.grey);
    }
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      height: 70,
      width: screenSize.width * .22, // عرض ثابت لكل عنصر
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: category.color,
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF7F7F7),
            blurRadius: 4,
            spreadRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Iconify(category.iconName, size: size, color: Colors.white),
      ),
    );
  }
}
