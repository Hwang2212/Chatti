import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  static const goName = "login-view";
  static const routeName = "/login-view";
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(children: []),
        );
      },
    );
  }
}
