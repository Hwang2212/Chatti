import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/services/services.dart';
import 'package:firebase_chat/view/onboarding/onboarding_view.dart';
import 'package:firebase_chat/viewmodel/src/onboarding_viewmodel.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
locator.registerLazySingleton(() => SharedPreferencesService());

// ViewModels
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => OnBoardingViewModel());

// Providers
  locator.registerFactory(() => AuthProvider());
}
