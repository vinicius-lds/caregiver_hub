import 'dart:io';

import 'package:caregiver_hub/employer/models/caregiver.dart';
import 'package:caregiver_hub/employer/widgets/caregiver_list_item/caregiver_list_item_mat.dart';
import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:flutter/widgets.dart';

class CaregiverListItem extends StatelessWidget {
  const CaregiverListItem({
    Key? key,
    required this.caregiver,
  }) : super(key: key);

  final Caregiver caregiver;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return CaregiverListItemMat(
        caregiver: caregiver,
      );
    }
    throw NotImplementedException('CaregiverListItem');
  }
}
