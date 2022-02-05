import 'package:caregiver_hub/location/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacePickerOpacity extends StatelessWidget {
  const PlacePickerOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Provider.of<PlaceProvider>(context).showingResults()
          ? Colors.black45
          : null,
    );
  }
}
