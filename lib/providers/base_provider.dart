import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  String? _status;
  String? get status => _status;
  String? _errorMessage;
  String? get error => _errorMessage;
  bool get hasError => _errorMessage != null;
  void setError(String? status, String? errorMessage) {
    _status = status;
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
