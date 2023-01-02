import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
// locator.registerLazySingleton(() => AuthService());

// ViewModels
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => SplashViewModel());

// Providers
  locator.registerFactory(() => AuthProvider());
}
