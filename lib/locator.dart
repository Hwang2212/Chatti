import 'package:firebase_chat/services/services.dart';

import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => SnackBarService());

// ViewModels
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => OnboardingViewModel());

// Providers
}
