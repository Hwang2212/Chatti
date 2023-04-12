import 'package:firebase_chat/services/firebase/firestore.dart';
import 'package:firebase_chat/services/services.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => SnackBarService());
  locator.registerLazySingleton(() => FirestoreService());

// ViewModels
  // locator.registerFactory(() => LoginViewModel());
  // // locator.registerFactory(() => HomeViewModel(firestoreService: null));
  // locator.registerFactory(() => SplashViewModel());
  // locator.registerFactory(() => OnboardingViewModel());

// Providers
}
