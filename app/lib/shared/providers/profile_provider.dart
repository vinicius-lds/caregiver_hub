import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier {
  bool _isCaregiver = false;

  bool get isCaregiver {
    return _isCaregiver;
  }

  set isCaregiver(bool value) {
    _isCaregiver = value;
    notifyListeners();
  }
}
