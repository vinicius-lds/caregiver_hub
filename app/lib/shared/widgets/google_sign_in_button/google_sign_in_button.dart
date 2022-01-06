import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/widgets/google_sign_in_button/google_sign_in_button_mat.dart';
import 'package:flutter/widgets.dart';

class GoogleSignInButton extends StatelessWidget {
  final void Function() onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return GoogleSignInButtonMat(
        onPressed: onPressed,
      );
    }
    throw NotImplementedException('GoogleSignInButton');
  }
}
