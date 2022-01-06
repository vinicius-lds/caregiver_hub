import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/widgets/form_button_footer/form_button_footer_mat.dart';
import 'package:flutter/widgets.dart';

class FormButtonFooter extends StatelessWidget {
  const FormButtonFooter({
    Key? key,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimary,
    required this.onSecondary,
  }) : super(key: key);

  final String primaryText;
  final String secondaryText;
  final void Function() onPrimary;
  final void Function() onSecondary;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return FormButtonFooterMat(
        primaryText: primaryText,
        secondaryText: secondaryText,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
      );
    }
    throw NotImplementedException('FormButtonFooter');
  }
}
