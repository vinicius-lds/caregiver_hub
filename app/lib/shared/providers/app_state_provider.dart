import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppStateProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  bool _isCaregiver = false;
  String _id = '';

  AppStateProvider() {
    _auth.idTokenChanges().listen((event) {
      id = event?.uid ?? '';
    });
  }

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
