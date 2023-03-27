import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/core/utils/enums/src/firebaseauth_enums.dart';
import 'package:firebase_chat/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  bool _isValidated = false;
  bool get isValidated => _isValidated;
  FirebaseAuthStatus _finalStatus = FirebaseAuthStatus.uninitialized;
  FirebaseAuthStatus get finalStatus => _finalStatus;

  void onChanged(String? value) {
    _isValidated = _signUpFormKey.currentState?.validate() ?? false;
  }

  Future<void> onTapSignInGoogle(BuildContext context) async {
    FirebaseAuthStatus status =
        await context.read<AuthProvider>().googleLogIn();
    _finalStatus = status;
    notifyListeners();
  }

  Future<void> onTapSignInEmail(BuildContext context,
      {required String email, required String password}) async {
    FirebaseAuthStatus status =
        await context.read<AuthProvider>().emailLogIn(email, password);
    _finalStatus = status;
    notifyListeners();
  }
}
