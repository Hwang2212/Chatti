import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/splash/splash_view_model.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  static const routeName = '/';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (_) => SplashViewModel(),
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
