import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/services/services.dart';
import 'package:firebase_chat/utils/enums/src/firebaseauth_enums.dart';
import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/home/home_view.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/view/widgets/global_widgets.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../viewmodel/src/signup_viewmodel.dart';

class SignUpView extends StatefulWidget {
  static const goName = 'login-view';
  static const routeName = '/login-view';

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _passwordTEC = TextEditingController();

  final TextEditingController _emailTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(children: [
            const BackgroundWidget(),
            Positioned.fill(
                top: AppPadding.p20, child: buildMainContent(viewModel)),
          ]),
        );
      },
    );
  }

  Widget buildMainContent(SignUpViewModel viewModel) {
    return Padding(
      padding: AppPadding.contentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),

          buildTextForms(viewModel),
          // buildPageView(),
          // buildDescriptionCard(),
          // pageIndicator(),
          // buildNextandBackButton(),
          const SizedBox(
            height: AppSize.s50,
          ),
          buildSignInButton(viewModel),
          const SizedBox(
            height: AppSize.s20,
          ),
          Center(
              child: Text(
            "OR",
            style: getExtraBoldStyle(
                fontSize: FontSize.s20, color: AppColors.greYest),
          )),
          const SizedBox(
            height: AppSize.s20,
          ),
          buildGoogleButton(viewModel)
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Login",
          style: getExtraBoldStyle(fontSize: FontSize.s40),
        ),
        Text("Use your Google to Sign In!",
            style:
                getLightStyle(fontSize: FontSize.s16, color: AppColors.greYest))
      ],
    );
  }

  Widget buildTextForms(SignUpViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormField(
            validator: FormValidators.validatePhoneNumber,
            onChanged: viewModel.onChanged,
            textInputAction: TextInputAction.next,
            isNumber: true,
            textEditingController: _emailTEC,
            labelText: "Email",
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          AppTextFormField(
            validator: FormValidators.validateEmail,
            onChanged: viewModel.onChanged,
            textInputAction: TextInputAction.done,
            textEditingController: _passwordTEC,
            labelText: "Password",
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton(SignUpViewModel viewModel) {
    return SizedBox(
      height: AppSize.s40,
      width: double.infinity,
      child: AppElevatedButton.text(
        onPressed: () {},
        text: "Sign In",
        textColor: AppColors.black,
      ),
    );
  }

  Widget buildGoogleButton(SignUpViewModel viewModel) {
    return SizedBox(
      height: AppSize.s40,
      width: double.infinity,
      child: AppElevatedButton.icon(
        onPressed: () {
          viewModel.onTapSignIn(context);
          if (viewModel.finalStatus == FirebaseAuthStatus.authenticated) {
            context.go(HomeView.routeName);
          } else {
            locator<SnackBarService>().show(
                context: context,
                text: "Login Fail",
                actionText: "Dismiss",
                actionOnPressed: () {});
          }
        },
        text: "Google Sign In",
        textColor: AppColors.black,
        icon: CircleAvatar(
            backgroundColor: AppColors.white,
            child: Image.asset(
              AppAssets.googleIcon,
              height: AppSize.s30,
              width: AppSize.s30,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
