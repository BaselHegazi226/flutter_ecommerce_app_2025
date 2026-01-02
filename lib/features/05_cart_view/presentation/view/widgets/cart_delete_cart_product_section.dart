import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/utilities/custom_dialog_state.dart';
import '../../../../../core/utilities/icon_with_circle_style.dart';
import '../../view_model/cart_bloc/cart_bloc.dart';

class DeleteCartProductSection extends StatelessWidget {
  const DeleteCartProductSection({super.key, required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context) {
    return IconWithCircleStyle(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade500.withAlpha(32)
          : Colors.grey.shade400,
      widget: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          warningAwesomeDialog(
            context,
            title: S.of(context).cart_delete_product_title,
            description: S.of(context).cart_delete_product_desc,
            buttonAcceptText: S.of(context).warning_button_title_ok,
            buttonCancelText: S.of(context).warning_button_title_Cancel,
            onPressed: () {
              context.read<CartBloc>().add(DeleteProductEvent(id: productId));
            },
          );
        },
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade50
              : Colors.black,
        ),
      ),
    );
  }
}
