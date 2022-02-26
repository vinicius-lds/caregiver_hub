import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class LocationField extends FormField<Location?> {
  LocationField({
    InputDecoration? decoration,
    FormFieldSetter<Location?>? onSaved,
    FormFieldSetter<Location?>? onChange,
    FormFieldValidator<Location?>? validator,
    Location? initialValue,
    bool readOnly = false,
    bool disabled = false,
    bool autovalidate = false,
    bool radiusSelection = false,
    double? radiusMinValue,
    double? radiusMaxValue,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<Location?> state) {
            String _getInputText(Location? location) {
              if (location == null) {
                return '';
              } else if (location.radius != null) {
                final kilometerRadius = (location.radius! / 1000)
                    .toStringAsFixed(1)
                    .replaceAll('.', ',');
                return '$kilometerRadius km ao redor de ${location.placeDescription}';
              } else {
                return location.placeDescription;
              }
            }

            final controller = TextEditingController();
            controller.text = _getInputText(state.value);
            return IgnorePointer(
              ignoring: disabled,
              child: InkWell(
                onTap: () async {
                  final args = {
                    'initialLocation': state.value,
                    'readOnly': readOnly,
                    'radiusSelection': radiusSelection,
                    'radiusMinValue': radiusMinValue,
                    'radiusMaxValue': radiusMaxValue,
                  };
                  final location = await Navigator.of(state.context)
                      .pushNamed(Routes.placePicker, arguments: args);
                  if (state.value != location) {
                    state.didChange(location as Location?);
                    controller.text = _getInputText(location);
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    decoration: decoration,
                    controller: controller,
                    validator: (value) =>
                        validator == null ? null : validator(state.value),
                    readOnly: true,
                  ),
                ),
              ),
            );
          },
        );
}
