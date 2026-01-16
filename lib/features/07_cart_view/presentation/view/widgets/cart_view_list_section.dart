import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/cart_view_total_checkout_section.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/cart_model.dart';
import 'cart_view_item.dart';

class CartViewListSection extends StatelessWidget {
  const CartViewListSection({
    super.key,
    required this.screenSize,
    required this.cartList,
  });

  final Size screenSize;
  final List<CartModel> cartList;

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      mobileWidget: CartViewListViewMobile(
        screenSize: screenSize,
        cartList: cartList,
      ),
      tabletWidget: CartViewListTablet(
        screenSize: screenSize,
        cartList: cartList,
      ),
    );
  }
}

class CartViewListViewMobile extends StatelessWidget {
  const CartViewListViewMobile({
    super.key,
    required this.screenSize,
    required this.cartList,
  });

  final Size screenSize;
  final List<CartModel> cartList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
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
                  GoRouter.of(
                    context,
                  ).push(Routes.productDetailsView, extra: item.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CartViewItemMobile(
                    productId: item.id,
                    title: item.title,
                    imageUrl: item.imageUrl,
                    price: item.price,
                    count: item.productCount,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.paddingOf(context).bottom,
          child: const CartViewTotalCheckoutSection(),
        ),
        //const CartViewTotalCheckoutSection(),
      ],
    );
  }
}

class CartViewListTablet extends StatelessWidget {
  const CartViewListTablet({
    super.key,
    required this.screenSize,
    required this.cartList,
  });

  final Size screenSize;
  final List<CartModel> cartList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              final item = cartList[index];
              return InkWell(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).push(Routes.productDetailsView, extra: item.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CartViewItemTablet(
                    productId: item.id,
                    title: item.title,
                    imageUrl: item.imageUrl,
                    price: item.price,
                    count: item.productCount,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: MediaQuery.paddingOf(context).bottom,
          child: const CartViewTotalCheckoutSection(),
        ),
      ],
    );
  }
}
