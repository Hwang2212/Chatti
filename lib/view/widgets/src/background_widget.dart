import 'package:firebase_chat/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.screenHeight,
      width: ScreenUtils.screenWidth,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.white, AppColors.aquaBlue])),
    );
  }
}
