import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';

import '../../../../../core/utilities/custom_dialog_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../05_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';

class FavouriteDeleteSection extends StatelessWidget {
  const FavouriteDeleteSection({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;

  @override
  Widget build(BuildContext context) {
    return IconWithCircleStyle(
      paddingValue: 0,
      backgroundColor: Colors.grey.shade500.withAlpha(64),
      onPressed: () {
        warningAwesomeDialog(
          context,
          title: S.of(context).cart_delete_product_title,
          description: S.of(context).cart_delete_product_desc,
          buttonAcceptText: S.of(context).warning_button_title_ok,
          buttonCancelText: S.of(context).warning_button_title_Cancel,
          onPressed: () {
            context.read<FavouriteProductCubit>().deleteFavoriteProduct(
              favouriteModel: favouriteModel,
            );
          },
          cancelOnPressed: () {},
        );
      },
      icon: Icon(
        Icons.delete_rounded,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade50
            : Colors.black87,
        size: 18,
      ),
    );
  }
}
