import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';

import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/login/login_view.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/view/widgets/global_widgets.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../viewmodel/view_model.dart';

class OnboardingView extends StatefulWidget {
  static const goName = 'onboarding-view';
  static const routeName = '/onboarding-view';

  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final introScreenController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardingViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(children: [
            const BackgroundWidget(),
            Positioned.fill(top: AppPadding.p20, child: buildMainContent()),
          ]),
        );
      },
    );
  }

  Widget buildMainContent() {
    return Padding(
      padding: AppPadding.contentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [buildPageView()],
      ),
    );
  }

  List<String> introAssets = [
    AppAssets.onboardingString1,
    AppAssets.onboardingString2,
    AppAssets.onboardingString3,
  ];
  Widget buildPageView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Chatti!",
            // textAlign: TextAlign.center,
            style: getBoldStyle(fontSize: FontSize.s40),
          ),
          SizedBox(
            height: ScreenUtils.screenHeight * 0.05,
          ),
          SizedBox(
            height: ScreenUtils.screenHeight * 0.4,
            width: ScreenUtils.screenWidth * 0.8,
            child: PageView(
              controller: introScreenController,
              children: [
                ...introAssets.map((e) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      e,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              ],
            ),
          )
        ]);
  }
}
