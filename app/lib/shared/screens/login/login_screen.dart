import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/screens/login/login_screen_mat.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const LoginScreenMat();
    }
    throw NotImplementedException('LoginScreen');
  }
}
