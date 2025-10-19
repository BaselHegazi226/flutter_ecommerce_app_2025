import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
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
    final screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                          UpdateProductCountEvent(
                            newCount: count + 1,
                            productId: id,
                          ),
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
              ),
            ),
            SizedBox(width: screenSize.width * .02),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  labelText: 'Count ',
                  labelStyle: const TextStyle(fontSize: 12, color: kGreyColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
                  ),
                ),
                onSubmitted: (value) {},
              ),
            ),
          ],
        );
      },
    );
  }
}
