import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/themes/src/app_fonts.dart';
import 'package:firebase_chat/themes/src/app_padding.dart';
import 'package:firebase_chat/themes/src/textstyle_manager.dart';
import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/login/login_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardingViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(children: [
            const BackgroundWidget(),
            buildMainContent(),
          ]),
        );
      },
    );
  }

  Widget buildMainContent() {
    return Padding(
      padding: AppPadding.contentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buildPageView()],
      ),
    );
  }

  Widget buildPageView() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.chattiIsAnApp.tr(),
                textAlign: TextAlign.center,
                style: getLightStyle(fontSize: FontSize.s24),
              )
            ]),
      ),
    );
  }
}
