import 'package:firebase_chat/view/themes/src/app_colors.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1.5],
              colors: [AppColors.white, AppColors.lightBlue])),
    );
  }
}
