import 'dart:io';

import 'package:caregiver_hub/employer/screens/caregiver_filter_screen/caregiver_filter_screen_mat.dart';
import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:flutter/widgets.dart';

class CaregiverFilterScreen extends StatelessWidget {
  const CaregiverFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const CaregiverFilterScreenMat();
    }
    throw NotImplementedException('CaregiverFilterScreen');
  }
}
