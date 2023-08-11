import 'package:flutter/foundation.dart';

class InboxProvider extends ChangeNotifier {
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
