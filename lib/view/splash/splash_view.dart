import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/viewmodel/src/splash_viewmodel.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  static const routeName = '/';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(children: [
            const Center(
              child: Text("Chatti App"),
            ),
          ]),
        );
      },
    );
  }
}
