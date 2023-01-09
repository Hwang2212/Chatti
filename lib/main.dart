import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/services/services.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferencesService sharedPreferencesService =
      await SharedPreferencesService.getInstance();
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: const [Locale('en', '')],
    fallbackLocale: const Locale('en', ''),
    child: MultiProvider(

        /// Add Providers Here
        providers: [
          ChangeNotifierProvider(create: (context) => AppViewModel()),
          ChangeNotifierProvider(create: (context) => SplashViewModel()),
          ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ], child: MyApp()),
  ));
}
