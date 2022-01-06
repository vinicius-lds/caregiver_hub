import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/widgets/loading/loading_mat.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const LoadingMat();
    }
    throw NotImplementedException('Loading');
  }
}
