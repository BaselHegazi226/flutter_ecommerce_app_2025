import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../view_model/cart_bloc/cart_bloc.dart';
import '../../view_model/cart_bloc/cart_state.dart';

class CartViewCountSection extends StatelessWidget {
  const CartViewCountSection({
    super.key,
    required this.count,
    required this.id,
  });

  final int id, count;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade500.withAlpha(32)
                : Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(
                    UpdateProductCountEvent(newCount: count + 1, productId: id),
                  );
                },
                icon: const Icon(Icons.add),
              ),
              CustomText(
                text: '$count',
                fontSize: 20,
                alignment: Alignment.center,
              ),
              IconButton(
                onPressed: () {
                  if (count > 1) {
                    context.read<CartBloc>().add(
                      UpdateProductCountEvent(
                        newCount: count - 1,
                        productId: id,
                      ),
                    );
                    debugPrint('product id = $id');
                    debugPrint('product count = $count');
                  }
                },
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartView5CountSection extends StatelessWidget {
  const CartView5CountSection({
    super.key,
    required this.count,
    required this.id,
  });

  final int id, count;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.yellow.shade500,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          child: IconButton(
            onPressed: () {
              context.read<CartBloc>().add(
                UpdateProductCountEvent(newCount: count + 5, productId: id),
              );
            },
            icon: const Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add, color: kPrimaryColor),
                CustomText(text: '5', fontSize: 20, color: kPrimaryColor),
              ],
            ),
          ),
        );
      },
    );
  }
}
