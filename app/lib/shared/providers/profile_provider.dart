import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier {
  bool _isCaregiver = false;
  String _id = '';

  bool get isCaregiver {
    return _isCaregiver;
  }

  String get id {
    return _id;
  }

  set isCaregiver(bool value) {
    _isCaregiver = value;
    notifyListeners();
  }

  set id(String value) {
    _id = value;
    notifyListeners();
  }
}
