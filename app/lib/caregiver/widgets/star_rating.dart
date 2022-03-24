import 'package:flutter/material.dart';

class StarRating extends FormField<double?> {
  StarRating({
    String? label,
    FormFieldSetter<double?>? onSaved,
    FormFieldValidator<double?>? validator,
    double? initialValue,
    bool displayOnly = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<double?> state) {
            Widget _buildStar(double value) {
              final IconData iconData;
              final normalizedValue = value - (state.value ?? 0);
              if (normalizedValue <= 0) {
                iconData = Icons.star;
              } else if (normalizedValue > 0 && normalizedValue < 1) {
                iconData = Icons.star_half;
              } else {
                iconData = Icons.star_border;
              }
              return GestureDetector(
                onTap: displayOnly ? null : () => state.didChange(value),
                child: Icon(iconData, color: Colors.yellow[600]),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStar(1),
                    _buildStar(2),
                    _buildStar(3),
                    _buildStar(4),
                    _buildStar(5),
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
