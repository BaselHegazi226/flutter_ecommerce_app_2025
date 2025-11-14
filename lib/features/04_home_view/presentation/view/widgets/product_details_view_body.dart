import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_details_category_color_section.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_details_icon_section.dart';

import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * .4,
              child: CachedNetworkImage(
                imageUrl: productModel.images[0],
                placeholder: (context, value) {
                  return Container(color: Colors.grey);
                },
                errorWidget: (context, error, child) {
                  return const Icon(Icons.image);
                },
                fit: BoxFit.fill,
              ),
            ),
            ProductDetailsIconSection(
              screenSize: screenSize,
              productModel: productModel,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: productModel.title,
                alignment: Alignment.topLeft,
                fontSize: 22,
              ),
              const SizedBox(height: 26),
              ProductDetailsCategoryRatingSection(
                category: productModel.category,
                rating: productModel.rating,
              ),
              const SizedBox(height: 32),
              CustomText(text: S.of(context).Details, fontSize: 18),
              const SizedBox(height: 4),
              CustomText(
                text: productModel.description,
                fontSize: 14,
                height: 2.5,
                color: Colors.black.withAlpha(220),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
