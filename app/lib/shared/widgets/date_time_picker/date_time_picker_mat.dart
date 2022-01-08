import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerMat extends FormField<DateTime?> {
  DateTimePickerMat({
    String? label,
    FormFieldSetter<DateTime?>? onSaved,
    FormFieldValidator<DateTime?>? validator,
    DateTime? initialValue,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<DateTime?> state) {
            final selectedValueToShow = state.value == null
                ? null
                : DateFormat('dd/MM/yyyy hh:mm')
                    .format(state.value as DateTime);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null) Text(label),
                Row(
                  children: [
                    if (selectedValueToShow != null)
                      Expanded(
                        child: Text(
                          selectedValueToShow,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: state.context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(3000),
                          );
                          if (date == null) {
                            return;
                          }
                          final time = await showTimePicker(
                            context: state.context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time == null) {
                            return;
                          }
                          final dateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                          state.didChange(dateTime);
                        },
                        child: const Text('Escolha uma data'),
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Text(
                    state.errorText ?? '',
                    style: TextStyle(color: Theme.of(state.context).errorColor),
                  ),
              ],
            );
          },
        );
}
