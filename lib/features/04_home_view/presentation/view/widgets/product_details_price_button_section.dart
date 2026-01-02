import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_state.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../generated/l10n.dart';
import '../../../../05_cart_view/data/model/cart_model.dart';

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
      title: S.of(context).homePrice,
      value: '${priceShowed(productModel.price)} ${S.of(context).EP}',
      widget: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          return CustomTextIconButton(
            onPressed: () {
              final CartModel cartModel = CartModel(
                id: productModel.id,
                price: productModel.price,
                title: productModel.title,
                imageUrl: productModel.images[0],
                addAt: DateTime.now(),
              );
              context.read<CartBloc>().add(
                AddToCartEvent(cartModel: cartModel),
              );
            },
            text: S.of(context).homeAddToCart,
            textColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade600
                : Colors.grey.shade200,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade200
                : kPrimaryColor,
            iconData: Icons.shopping_cart,
          );
        },
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            ToastNotification.flatToastNotificationService(
              title: S.of(context).success_addToCart_title,
              description: S.of(context).success_addToCart_desc,
              onAutoCompleteCompleted: (value) {},
              toastNotificationType: ToastificationType.success,
            );
          } else if (state is AddToCartFailure) {
            ToastNotification.flatToastNotificationService(
              title: S.of(context).error(state.errorMessage),
              onAutoCompleteCompleted: (value) {},
              toastNotificationType: ToastificationType.error,
            );
            debugPrint('error errrrrrrrrrrrrror = ${state.errorMessage}');
          } else if (state is AddToCartDone) {
            ToastNotification.minimalToastNotificationService(
              toastNotificationType: ToastificationType.info,
              title: productModel.title.split(" ").take(2).join(" "),
              description: S.of(context).order_added_done,
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
