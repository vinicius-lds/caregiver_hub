import 'dart:async';

import 'package:caregiver_hub/location/models/place_coordinates.dart';
import 'package:caregiver_hub/location/providers/place_provider.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapsPlace extends StatefulWidget {
  final LatLng? initialMarker;
  const GoogleMapsPlace({
    Key? key,
    this.initialMarker,
  }) : super(key: key);

  @override
  State<GoogleMapsPlace> createState() => _GoogleMapsPlaceState();
}

class _GoogleMapsPlaceState extends State<GoogleMapsPlace> {
  static const String markerId = 'f1f7d508-ff49-4adb-8cc7-c29c21256294';

  final Completer<GoogleMapController> _mapController = Completer();

  CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};
  StreamSubscription? _placeSubscription;

  @override
  void initState() {
    _loadInitialCameraPosition();
    _placeSubscription = Provider.of<PlaceProvider>(context, listen: false)
        .selectedPlaceCoordinatesStreamController
        .stream
        .listen(
          (placeCoordinates) => _onMarkerChanged(placeCoordinates?.coordinates),
        );
    _onMarkerChanged(widget.initialMarker);
    super.initState();
  }

  @override
  void dispose() {
    _placeSubscription?.cancel();
    super.dispose();
  }

  void _loadInitialCameraPosition() async {
    LatLng coordinates;
    if (widget.initialMarker != null) {
      coordinates = widget.initialMarker!;
    } else {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        coordinates = LatLng(position.latitude, position.longitude);
      } catch (e) {
        // Caso não tenha permissão, seta a furb como local inicial.
        coordinates = const LatLng(-26.904855945456372, -49.07916968582165);
      }
    }
    setState(
      () => initialCameraPosition = CameraPosition(
        target: coordinates,
        zoom: 15,
      ),
    );
  }

  void _onMarkerChanged(LatLng? coordinates) async {
    if (coordinates == null) {
      setState(() {
        markers = {};
      });
    } else {
      setState(() {
        markers = {
          Marker(
            markerId: const MarkerId(markerId),
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

  @override
  Widget build(BuildContext context) {
    if (initialCameraPosition == null) {
      return const Loading();
    }
    return SizedBox(
      height: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: markers,
        initialCameraPosition: initialCameraPosition!,
        onMapCreated: _mapController.complete,
      ),
    );
  }
}
