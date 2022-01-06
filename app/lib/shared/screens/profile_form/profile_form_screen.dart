import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/screens/profile_form/profile_form_screen_mat.dart';
import 'package:flutter/widgets.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const ProfileFormScreenMat();
    }
    throw NotImplementedException('ProfileForm');
  }
}
