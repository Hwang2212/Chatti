import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/utils/enums/src/firebaseauth_enums.dart';
import 'package:firebase_chat/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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



  void onTapSignIn(BuildContext context) async {
    FirebaseAuthStatus status = await locator<AuthProvider>().handleSignIn();
    _finalStatus = status;
    notifyListeners();
    // NavigatorState navigatorState = Navigator.of(context);

    // if (_isValidated) {
    //   Map<String, String> signUpBody = {
    //     "name": _nameTEC.text,
    //     "contact": _phoneNoTEC.text,
    //     "email": _emailTEC.text,
    //     "avatar": _profilePic!
    //   };

    //   await authProvider.createUserProfile(signUpBody);

    //   if (authProvider.signedUpStatus == Status.notSignedUp) {
    //     SnackBarService().show(
    //         context: context,
    //         text: LocaleKeys.userNotCreated.tr(),
    //         actionText: LocaleKeys.dismiss.tr(),
    //         actionOnPressed: () {});
    //   } else if (authProvider.signedUpStatus == Status.signedUp) {
    //     navigatorState.pushNamedAndRemoveUntil(
    //         MainScreen.routeName, ((route) => false));

    //     SnackBarService().show(
    //         context: context,
    //         text: LocaleKeys.userCreated.tr(),
    //         actionText: LocaleKeys.dismiss.tr(),
    //         actionOnPressed: () {});
    //   }
    // }
    // return;
  }
}
