import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceCoordinates extends Place {
  final LatLng coordinates;

  const PlaceCoordinates({
    required String id,
    required String description,
    required this.coordinates,
  }) : super(id: id, description: description);

  factory PlaceCoordinates.fromLocation(Location location) {
    return PlaceCoordinates(
      id: location.placeId,
      description: location.placeDescription,
      coordinates: location.coordinates,
    );
  }

  factory PlaceCoordinates.fromMap(Map<String, dynamic> doc) {
    return PlaceCoordinates(
      id: doc['id'],
      description: doc['description'],
      coordinates: LatLng(
        doc['coordinates']['latitude'],
        doc['coordinates']['longitude'],
      ),
    );
  }
}
