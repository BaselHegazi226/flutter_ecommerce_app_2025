import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/cart_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_state.dart';
import 'package:toastification/toastification.dart';

class ProductDetailsPriceButtonSection extends StatelessWidget {
  const ProductDetailsPriceButtonSection({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    debugPrint('product model = ${productModel.toJson()}');
    return PriceButtonSection(
      title: 'Price',
      value: '\$ ${productModel.price}',
      widget: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          return CustomButton(
            onPressed: () {
              final CartModel cartModel = CartModel(
                id: productModel.id,
                price: productModel.price,
                title: productModel.title,
                imageUrl: productModel.images[0],
              );
              context.read<CartBloc>().add(
                AddToCartEvent(cartModel: cartModel),
              );
            },
            text: 'Add To Cart',
          );
        },
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            ToastNotification.flatToastNotificationService(
              onAutoCompleteCompleted: (value) {},
              toastNotificationType: ToastificationType.success,
            );
          } else if (state is AddToCartFailure) {
            ToastNotification.flatToastNotificationService(
              onAutoCompleteCompleted: (value) {},
              toastNotificationType: ToastificationType.error,
            );
            debugPrint('error errrrrrrrrrrrrror = ${state.errorMessage}');
          } else if (state is AddToCartDone) {
            ToastNotification.minimalToastNotificationService(
              toastNotificationType: ToastificationType.info,
              title: productModel.title.split(" ").take(2).join(" "),
              description: 'is already added',

              onAutoCompleteCompleted: (value) {},
            );
          } else {
            debugPrint('loading add add adddddddd');
          }
        },
      ),
    );
  }
}
