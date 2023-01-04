import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/authenticate/login_view.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/widgets/widgets.dart';
import 'package:firebase_chat/viewmodel/src/splash_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';

class SplashView extends StatefulWidget {
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
      Future.delayed(const Duration(seconds: 3), () {
        context.goNamed(LoginView.goName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtils.setScreenSize(size);
    return BaseView<SplashViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(children: [
            const AppBackground(),
            Center(
              child: Text(LocaleKeys.chatti.tr(),
                  style: getExtraBoldStyle(fontSize: FontSize.s42)),
            ),
          ]),
        );
      },
    );
  }
}
