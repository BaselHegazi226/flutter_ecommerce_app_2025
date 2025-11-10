import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/cart_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/summarize_product_item.dart';

class SummarizeProductsOrderList extends StatelessWidget {
  const SummarizeProductsOrderList({super.key, required this.carts});
  final List<CartModel> carts;
  @override
  Widget build(BuildContext context) {
    if (carts.isNotEmpty) {
      return SizedBox(
        height: 230,
        child: ListView.separated(
          itemCount: carts.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, state) {
            return const SizedBox(width: 16);
          },
          itemBuilder: (context, index) {
            final item = carts[index];
            return SummarizeProductOrderItem(
              imageUrl: item.imageUrl,
              title: item.title,
              price: item.price,
              count: item.productCount,
            );
          },
        ),
      );
    } else {
      return const Text('No Product to Make order');
    }
  }
}
