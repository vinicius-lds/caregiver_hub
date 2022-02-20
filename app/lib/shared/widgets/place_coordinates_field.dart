import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class PlaceCoordinatesField extends FormField<PlaceCoordinates?> {
  PlaceCoordinatesField({
    InputDecoration? decoration,
    FormFieldSetter<PlaceCoordinates?>? onSaved,
    FormFieldSetter<PlaceCoordinates?>? onChange,
    FormFieldValidator<PlaceCoordinates?>? validator,
    PlaceCoordinates? initialValue,
    bool readOnly = false,
    bool disabled = false,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<PlaceCoordinates?> state) {
            final controller = TextEditingController();
            controller.text = state.value?.description ?? '';
            return IgnorePointer(
              ignoring: disabled,
              child: InkWell(
                onTap: () async {
                  final args = {
                    'initialPlaceCoordinates': state.value,
                    'readOnly': readOnly,
                  };
                  final placeCoordinates = await Navigator.of(state.context)
                      .pushNamed(Routes.placePicker, arguments: args);
                  if (state.value != placeCoordinates) {
                    state.didChange(placeCoordinates as PlaceCoordinates?);
                    controller.text = placeCoordinates?.description ?? '';
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
