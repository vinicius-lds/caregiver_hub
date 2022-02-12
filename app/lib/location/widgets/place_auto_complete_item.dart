import 'package:caregiver_hub/shared/models/place.dart';
import 'package:flutter/material.dart';

class PlaceAutoCompleteItem extends StatelessWidget {
  final Place place;
  final void Function(Place) onSelected;

  const PlaceAutoCompleteItem({
    Key? key,
    required this.place,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(place),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          place.description,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
