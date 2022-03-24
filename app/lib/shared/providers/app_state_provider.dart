import 'package:caregiver_hub/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:flutter/material.dart';

class AppStateProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _userService = getIt<UserService>();

  bool _isCaregiver = false;
  String _id = '';
  Map<String, dynamic>? _pendingNotificationData;

  AppStateProvider() {
    _auth.idTokenChanges().listen((event) async {
      id = event?.uid ?? '';
      // Atualiza o token fcm para permitir notificações por usuário.
      if (id.isNotEmpty) {
        await _userService.updateFCMUserToken(userId: id);
      }
    });
  }

  registerPendingNotificationData(Map<String, dynamic> data) {
    _pendingNotificationData = data;
  }

  Map<String, dynamic>? pollPendingNotificationData() {
    if (_pendingNotificationData != null) {
      final data = _pendingNotificationData;
      _pendingNotificationData = null;
      return data;
    }
    return null;
  }

  bool get isCaregiver {
    return _isCaregiver;
  }

  String get id {
    return _id;
  }

  set isCaregiver(bool value) {
    if (_isCaregiver != value) {
      _isCaregiver = value;
      notifyListeners();
    }
  }

  set id(String value) {
    _id = value;
    notifyListeners();
  }
}
