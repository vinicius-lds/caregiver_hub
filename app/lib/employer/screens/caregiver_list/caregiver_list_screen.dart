import 'dart:io';

import 'package:caregiver_hub/employer/screens/caregiver_list/caregiver_list_screen_mat.dart';
import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:flutter/material.dart';

class CaregiverListScreen extends StatelessWidget {
  const CaregiverListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const CaregiverListScreenMat();
    }
    throw NotImplementedException('CaregiverListScreen');
  }
}
