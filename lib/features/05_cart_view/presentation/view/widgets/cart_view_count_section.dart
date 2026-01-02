import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_state.dart';

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
            borderRadius: const BorderRadius.all(Radius.circular(4)),
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
