import 'dart:async';

import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/place.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/location/widgets/location_controls.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePickerScreen extends StatefulWidget {
  static const String markerId = 'f1f7d508-ff49-4adb-8cc7-c29c21256294';
  static const String circleId = '727f06da-974d-11ec-b909-0242ac120002';

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
  Location? _initialLocation;
  bool? _readOnly;
  bool? _radiusSelection;
  double? _radiusMinValue;
  double? _radiusMaxValue;
  Location? _selectedLocation;
  CameraPosition? _initialCameraPosition;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  void initState() {
    _initialLocation = widget.args?['initialLocation'];
    _readOnly = widget.args?['readOnly'];
    _radiusSelection = widget.args?['radiusSelection'];
    _radiusMinValue = widget.args?['radiusMinValue'];
    _radiusMaxValue = widget.args?['radiusMaxValue'];
    assert(!(_radiusSelection ?? false) ||
        ((_radiusMinValue != null && _radiusMinValue! > 0) &&
            (_radiusMaxValue != null && _radiusMaxValue! > _radiusMinValue!)));
    _selectedLocation = _initialLocation;
    _loadInitialCameraPosition();
    super.initState();
  }

  void _loadInitialCameraPosition() async {
    LatLng initialCameraPositionTarget;
    if (_initialLocation != null) {
      initialCameraPositionTarget = _initialLocation!.coordinates;
      _onMarkerChanged(_initialLocation!.coordinates);
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
    Navigator.of(context).pop(_initialLocation);
  }

  void _onConfirm(BuildContext context) {
    Navigator.of(context).pop(_selectedLocation);
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

  void _onRadiusChanged(BuildContext context, double radius) {
    _onChangeLocation(context, _selectedLocation!.copyWith(radius: radius));
  }

  void _onChangeLocation(BuildContext context, Location location) {
    _selectedLocation = location;
    _onMarkerChanged(location.coordinates);
    _updateRadiusCircle(context);
  }

  void _updateRadiusCircle(BuildContext context) {
    if (_selectedLocation != null && _selectedLocation!.radius != null) {
      final coordinates = _selectedLocation!.coordinates;
      final radius = _selectedLocation!.radius!;
      final circle = Circle(
        circleId: const CircleId(PlacePickerScreen.circleId),
        center: coordinates,
        radius: radius,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.25),
        strokeWidth: 1,
        strokeColor: Theme.of(context).primaryColor.withOpacity(0.75),
      );
      setState(() => _circles = {circle});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialCameraPosition == null) {
      return const Scaffold(body: Loading());
    }
    _mapController.future.whenComplete(() => _updateRadiusCircle(context));
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
              circles: _circles,
              zoomControlsEnabled: false,
            ),
          ),
          LocationControls(
            readOnly: _readOnly ?? false,
            initialLocation: _initialLocation,
            radiusSelection: _radiusSelection ?? false,
            radiusMinValue: _radiusMinValue,
            radiusMaxValue: _radiusMaxValue,
            onChangeLocation: (location) =>
                _onChangeLocation(context, location),
            onRadiusChanged: (metersValue) =>
                _onRadiusChanged(context, metersValue),
            onClear: () => _onClear(context),
            onCancel: () => _onCancel(context),
            onConfirm: () => _onConfirm(context),
          ),
        ],
      ),
    );
  }
}
