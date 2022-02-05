import 'dart:async';

import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final FormFieldSetter<String?>? onChange;

  int debounce;
  Timer? _debouncedOnChange;

  InputDecoration? decoration;
  TextEditingController? controller;

  TextFieldCustom({
    Key? key,
    required this.debounce,
    this.decoration,
    this.onChange,
    this.controller,
  }) : super(key: key);

  void _scheduleDebounce(String? value) {
    if (onChange != null) {
      if (_debouncedOnChange != null) {
        _debouncedOnChange!.cancel();
        _debouncedOnChange = null;
      }
      _debouncedOnChange = Timer(
        Duration(milliseconds: debounce),
        () => onChange!(value),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: decoration,
      onChanged: _scheduleDebounce,
    );
  }
}
