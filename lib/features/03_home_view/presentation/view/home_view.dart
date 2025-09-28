import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: screenSize.height * .08),
            ),
            _searchbarSection(),
            SliverToBoxAdapter(
              child: SizedBox(height: screenSize.height * .02),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  const CustomText(
                    text: 'Categories',
                    fontSize: 18,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(height: screenSize.height * .015),
                  _categoriesListView(screenSize),
                  SizedBox(height: screenSize.height * .03),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Best Selling',
                        fontSize: 18,
                        alignment: Alignment.topLeft,
                      ),
                      CustomText(
                        text: 'See All',
                        fontSize: 18,
                        alignment: Alignment.topRight,
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * .03),
                  _bestSellListView(screenSize),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _bestSellListView(Size screenSize) {
    return SizedBox(
      height: screenSize.height * .5,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * .4,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Image.asset(
                  Assets.images.home.image.path,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: screenSize.height * .015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  CustomText(
                    text: 'Leather Wristwatch',
                    fontSize: 16,
                    alignment: Alignment.topLeft,
                  ),
                  CustomText(
                    text: 'Bang and Olufsen',
                    fontSize: 12,
                    color: Color(0xff929292),
                    alignment: Alignment.topLeft,
                  ),
                  CustomText(
                    text: r'$450',
                    fontSize: 16,
                    color: kPrimaryColor,
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Container _categoriesListView(Size screenSize) {
    return Container(
      height: screenSize.height * .16,
      color: Colors.transparent,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 20);
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: screenSize.height * .12,
                width: screenSize.width * .2,
                padding: EdgeInsets.all(screenSize.width * .03),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffF7F7F7),
                      blurRadius: 10, // درجة التمويه
                      spreadRadius: 4, // انتشار الظل
                      offset: Offset(0, 8), // مكانه بالنسبة للدائرة
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  Assets.images.home.path48,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenSize.height * .015),
              CustomText(
                text: 'Men',
                fontSize: 12,
                alignment: Alignment.topLeft,
              ),
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter _searchbarSection() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SearchBar(
          backgroundColor: WidgetStatePropertyAll(Color(0xffF6F6F6)),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
          leading: Icon(Icons.search_outlined, color: Colors.black),
        ),
      ),
    );
  }
}
