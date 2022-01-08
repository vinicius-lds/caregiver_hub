import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_stream/multi_select_chip_field_stream_mat.dart';
import 'package:flutter/widgets.dart';

class MultiSelectChipFieldStream<T, K> extends StatelessWidget {
  final Stream<List<T?>> items;
  final String title;
  final String Function(T?) labelFn;
  final K Function(T?) idFn;
  final Function(List<T?>)? onTap;

  const MultiSelectChipFieldStream({
    Key? key,
    required this.items,
    required this.title,
    required this.labelFn,
    required this.idFn,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return MultiSelectChipFieldStreamMat(
        items: items,
        title: title,
        labelFn: labelFn,
        idFn: idFn,
        onTap: onTap,
      );
    }
    throw NotImplementedException('MultiSelectChipFieldStream');
  }
}
