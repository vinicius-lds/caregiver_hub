import 'dart:io';

import 'package:caregiver_hub/ui/employer/signup/signup_screen_mat.dart';
import 'package:caregiver_hub/ui/shared/exceptions/not_implemented_exception.dart';
import 'package:flutter/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const SignupScreenMat();
    }
    throw NotImplementedException('SignupScreen');
  }
}
