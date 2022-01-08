import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/widgets/date_time_picker/date_time_picker_mat.dart';
import 'package:flutter/widgets.dart';

class DateTimePicker extends StatelessWidget {
  final String? label;
  final FormFieldSetter<DateTime?>? onSaved;
  final FormFieldValidator<DateTime?>? validator;
  final DateTime? initialValue;
  final bool autovalidate;

  const DateTimePicker({
    Key? key,
    this.label,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return DateTimePickerMat(
        label: label,
        onSaved: onSaved,
        validator: validator,
        initialValue: initialValue,
        autovalidate: autovalidate,
      );
    }
    throw NotImplementedException('DateTimePicker');
  }
}
