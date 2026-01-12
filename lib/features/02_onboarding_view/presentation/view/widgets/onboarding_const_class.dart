import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../generated/assets.dart';
import '../../../data/model/onboarding_item_model.dart';

class OnboardingConstClass {
  static List<OnboardingItemModel> onboardingDataFun(BuildContext context) {
    List<OnboardingItemModel> onboardingDataList = [
      OnboardingItemModel(
        image: Assets.onboardingImage1,
        title1: S.of(context).onBoardingTitleImg1,
        subTitle: S.of(context).onBoardingDescImg1,
      ),
      OnboardingItemModel(
        image: Assets.onboardingImage2,
        title1: S.of(context).onBoardingTitleImg2,
        subTitle: S.of(context).onBoardingDescImg2,
      ),
      OnboardingItemModel(
        image: Assets.onboardingImage3,
        title1: S.of(context).onBoardingTitleImg3,
        subTitle: S.of(context).onBoardingDescImg3,
      ),
    ];
    return onboardingDataList;
  }
}
