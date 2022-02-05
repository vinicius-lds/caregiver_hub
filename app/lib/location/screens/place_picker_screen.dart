import 'package:caregiver_hub/location/widgets/place_auto_complete.dart';
import 'package:caregiver_hub/location/widgets/place_picker_opacity.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePickerScreen extends StatefulWidget {
  const PlacePickerScreen({Key? key}) : super(key: key);

  @override
  State<PlacePickerScreen> createState() => _PlacePickerScreenState();
}

class _PlacePickerScreenState extends State<PlacePickerScreen> {
  CameraPosition? initialCameraPosition;

  @override
  void initState() {
    _loadInitialCameraPosition();
  }

  void _loadInitialCameraPosition() async {
    LatLng coordinates;
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      coordinates = LatLng(position.latitude, position.longitude);
    } catch (e) {
      // Caso não tenha permissão, seta a furb como local inicial.
      coordinates = const LatLng(-26.904855945456372, -49.07916968582165);
    }
    setState(
      () => initialCameraPosition = CameraPosition(
        target: coordinates,
        zoom: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (initialCameraPosition == null) {
      return const Loading();
    }
    return Scaffold(
      body: LayoutBuilder(
        builder: (bContext, constraints) => Stack(
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: initialCameraPosition!,
              ),
            ),
            const PlacePickerOpacity(),
            PlaceAutoComplete(),
          ],
        ),
      ),
    );
  }
}
