import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/viewmodel/login_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
// locator.registerLazySingleton(() => AuthService());

// ViewModels
  locator.registerFactory(() => LoginViewModel());

// Providers
  locator.registerFactory(() => AuthProvider());
}
