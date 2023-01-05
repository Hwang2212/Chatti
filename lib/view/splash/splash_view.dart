import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';

import 'package:firebase_chat/view/onboarding/onboarding_view.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/view/widgets/global_widgets.dart';
import 'package:firebase_chat/viewmodel/src/splash_viewmodel.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  static const goName = 'splash';
  static const routeName = '/';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), pushToNextScreen);
    });
  }

  void pushToNextScreen() {
    context.go(OnboardingView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtils.setScreenSize(size);
    return BaseView<SplashViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(children: [
            const BackgroundWidget(),
            Center(
              child: Text(
                LocaleKeys.chatti.tr(),
                style: getBoldStyle(fontSize: FontSize.s24),
              ),
            ),
          ]),
        );
      },
    );
  }
}
