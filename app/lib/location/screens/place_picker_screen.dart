import 'dart:async';

import 'package:caregiver_hub/shared/models/place.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/location/widgets/place_auto_complete.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePickerScreen extends StatefulWidget {
  static const String markerId = 'f1f7d508-ff49-4adb-8cc7-c29c21256294';

  final Map<String, dynamic>? args;

  const PlacePickerScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<PlacePickerScreen> createState() => _PlacePickerScreenState();
}

class _PlacePickerScreenState extends State<PlacePickerScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  PlaceCoordinates? _initialPlaceCoordinates;
  bool? _readOnly;
  PlaceCoordinates? _selectedPlaceCoordinates;
  CameraPosition? _initialCameraPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    _initialPlaceCoordinates = widget.args?['initialPlaceCoordinates'];
    _readOnly = widget.args?['readOnly'];
    _selectedPlaceCoordinates = _initialPlaceCoordinates;
    _loadInitialCameraPosition();
    super.initState();
  }

  void _loadInitialCameraPosition() async {
    LatLng initialCameraPositionTarget;
    if (_initialPlaceCoordinates != null) {
      initialCameraPositionTarget = _initialPlaceCoordinates!.coordinates;
      _onMarkerChanged(_initialPlaceCoordinates!.coordinates);
    } else {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        initialCameraPositionTarget =
            LatLng(position.latitude, position.longitude);
      } catch (e) {
        // Caso não tenha permissão, seta a furb como local inicial.
        initialCameraPositionTarget =
            const LatLng(-26.904855945456372, -49.07916968582165);
      }
    }
    setState(
      () => _initialCameraPosition = CameraPosition(
        target: initialCameraPositionTarget,
        zoom: 15,
      ),
    );
  }

  void _onClear(BuildContext context) {
    Navigator.of(context).pop(null);
  }

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop(_initialPlaceCoordinates);
  }

  void _onConfirm(BuildContext context) {
    Navigator.of(context).pop(_selectedPlaceCoordinates);
  }

  void _onMarkerChanged(LatLng? coordinates) async {
    if (coordinates == null) {
      setState(() {
        _markers = {};
      });
    } else {
      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId(PlacePickerScreen.markerId),
            position: coordinates,
          )
        };
      });
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: coordinates,
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _onSelectedPlaceCoordinates(PlaceCoordinates placeCoordinates) {
    _onMarkerChanged(placeCoordinates.coordinates);
    _selectedPlaceCoordinates = placeCoordinates;
  }

  @override
  Widget build(BuildContext context) {
    if (_initialCameraPosition == null) {
      return const Loading();
    }
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: _markers,
              initialCameraPosition: _initialCameraPosition!,
              onMapCreated: _mapController.complete,
            ),
          ),
          PlaceAutoComplete(
            readOnly: _readOnly ?? false,
            initialPlace: _initialPlaceCoordinates != null
                ? Place.from(_initialPlaceCoordinates!)
                : null,
            onSelectedPlaceCoordinates: _onSelectedPlaceCoordinates,
            onClear: () => _onClear(context),
            onCancel: () => _onCancel(context),
            onConfirm: () => _onConfirm(context),
          ),
        ],
      ),
    );
  }
}
