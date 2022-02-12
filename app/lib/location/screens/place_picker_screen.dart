import 'package:caregiver_hub/location/models/place.dart';
import 'package:caregiver_hub/location/models/place_coordinates.dart';
import 'package:caregiver_hub/location/providers/place_provider.dart';
import 'package:caregiver_hub/location/widgets/google_maps_place.dart';
import 'package:caregiver_hub/location/widgets/place_auto_complete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacePickerScreen extends StatelessWidget {
  PlaceCoordinates? _initialPlaceCoordinates;
  PlaceCoordinates? _selectedPlaceCoordinates;

  PlacePickerScreen({Key? key}) : super(key: key);

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop(_initialPlaceCoordinates);
  }

  void _onConfirm(BuildContext context) {
    Navigator.of(context).pop(_selectedPlaceCoordinates);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>?;
    _initialPlaceCoordinates =
        args?['initialPlaceCoordinates'] as PlaceCoordinates?;
    Provider.of<PlaceProvider>(context)
        .selectedPlaceCoordinatesStreamController
        .stream
        .listen(
          (placeCoordinates) => _selectedPlaceCoordinates = placeCoordinates,
        );
    return Scaffold(
      body: Stack(
        children: [
          GoogleMapsPlace(),
          PlaceAutoComplete(
            initialPlace: _initialPlaceCoordinates != null
                ? Place.from(_initialPlaceCoordinates!)
                : null,
            onCancel: () => _onCancel(context),
            onConfirm: () => _onConfirm(context),
          ),
        ],
      ),
    );
  }
}
