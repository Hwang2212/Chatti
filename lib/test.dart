import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_chat/app/app.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState() {
    MyApp.instance.appState = 0;
  }

  void getAppState() {
    log("[APP STATE] ${MyApp.instance.appState}");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
