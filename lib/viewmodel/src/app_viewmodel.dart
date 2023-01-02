import 'package:firebase_chat/viewmodel/base_viewmodel.dart';

class AppViewModel extends BaseViewModel {
  bool isDarkMode = true;

  setDarkMode() {
    isDarkMode = true;
    notifyListeners();
  }

  setLightMode() {
    isDarkMode = false;
    notifyListeners();
  }
}
