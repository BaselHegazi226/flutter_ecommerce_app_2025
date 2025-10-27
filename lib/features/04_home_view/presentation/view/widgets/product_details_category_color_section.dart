import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';

import '../../../../../core/utilities/custom_text.dart';

class ProductDetailsCategoryColorSection extends StatelessWidget {
  const ProductDetailsCategoryColorSection({
    super.key,
    required this.category,
    required this.rating,
    //required this.id,
  });

  final String category;
  final double rating;
  //final int id;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 24,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: const Color(0xffEBEBEB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Category',
                  fontSize: 14,
                  alignment: Alignment.centerLeft,
                ),
                CustomText(
                  text: category,
                  fontSize: 14,
                  alignment: Alignment.centerRight,
                  color: kGreyColor,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: const Color(0xffEBEBEB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Rating',
                  fontSize: 14,
                  alignment: Alignment.centerLeft,
                ),
                Row(
                  spacing: 4,
                  children: [
                    CustomText(
                      text: rating.toString(),
                      fontSize: 14,
                      alignment: Alignment.centerRight,
                    ),
                    Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                  ],
                ),

                // CustomText(
                //   text: 'Color',
                //   fontSize: 14,
                //   alignment: Alignment.centerLeft,
                // ),
                //   Container(
                //     width: 22,
                //     height: 22,
                //     decoration: BoxDecoration(
                //       color: id < 3 ? Colors.blue : Colors.green,
                //       borderRadius: const BorderRadius.all(Radius.circular(8)),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
