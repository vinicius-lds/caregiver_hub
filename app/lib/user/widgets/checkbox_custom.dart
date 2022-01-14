import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxCustom extends FormField<bool?> {
  CheckboxCustom({
    FormFieldSetter<bool?>? onSaved,
    FormFieldValidator<bool?>? validator,
    String trueLabel = 'True',
    String falseLabel = 'False',
    bool autovalidate = false,
    bool initialValue = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<bool?> state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: (state.value ?? initialValue),
                  onChanged: state.didChange,
                ),
                Text((state.value ?? false) ? trueLabel : falseLabel),
              ],
            );
          },
        );
}
