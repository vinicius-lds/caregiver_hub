import 'dart:async';

import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final FormFieldSetter<String?>? onChanged;

  int debounce;
  Timer? _debouncedOnChange;

  InputDecoration? decoration;
  TextEditingController? controller;
  FocusNode? focusNode;

  TextFieldCustom({
    Key? key,
    required this.debounce,
    this.decoration,
    this.onChanged,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  void _scheduleDebounce(String? value) {
    if (onChanged != null) {
      if (_debouncedOnChange != null) {
        _debouncedOnChange!.cancel();
        _debouncedOnChange = null;
      }
      _debouncedOnChange = Timer(
        Duration(milliseconds: debounce),
        () => onChanged!(value),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: decoration,
      focusNode: focusNode,
      onChanged: _scheduleDebounce,
    );
  }
}
