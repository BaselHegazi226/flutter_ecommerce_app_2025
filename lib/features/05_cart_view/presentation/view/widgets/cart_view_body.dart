import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/cart_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/cart_view_item.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_state.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'cart_view_total_checkout_section.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is GetProductCartAndTotalSuccess) {
          final cartList = state.carts;
          if (cartList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.cartEmptyCart,
                  height: screenSize.height * .25,
                ),
                const SizedBox(height: 16),
                const CustomText(
                  text: 'No Product cart are added 🛒🛒',
                  fontSize: 20,
                  alignment: Alignment.center,
                  color: Colors.black,
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: screenSize.height * .02);
                  },
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    final item = cartList[index];
                    return InkWell(
                      onTap: () {
                        //push
                        GoRouter.of(
                          context,
                        ).push(Routes.productDetailsView, extra: item.id);
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Slidable(
                          closeOnScroll: true,
                          endActionPane: ActionPane(
                            extentRatio: 1,
                            motion: const ScrollMotion(),
                            children: [
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.red,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                            DeleteProductEvent(
                                              cartModel: cartList[index],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                          child: CartViewItem(
                            productId: item.id,
                            title: item.title,
                            imageUrl: item.imageUrl,
                            price: item.price,
                            count: item.productCount,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const CartViewTotalCheckoutSection(),
            ],
          );
        } else if (state is GetProductCartAndTotalFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return cartViewItemShimmerList(screenSize);
        }
      },
    );
  }
}
