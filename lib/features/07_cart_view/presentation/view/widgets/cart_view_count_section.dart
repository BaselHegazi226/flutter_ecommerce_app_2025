import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../../../../core/helper/const.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: isDark
                ? kGreyColor.withAlpha(60)
                : kPrimaryColor.withAlpha(20),
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            border: Border.all(
              color: isDark
                  ? Colors.grey.shade300
                  : kPrimaryColor.withAlpha(120),
            ),
          ),
          child: IconButton(
            onPressed: () {
              context.read<CartBloc>().add(
                UpdateProductCountEvent(newCount: count + 5, productId: id),
              );
            },
            icon: CustomText(
              text: '+5',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? Colors.grey.shade300
                  : kPrimaryColor.withAlpha(120),
            ),
          ),
        );
      },
    );
  }
}
