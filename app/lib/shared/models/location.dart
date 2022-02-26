import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final String placeId;
  final String placeDescription;
  final LatLng coordinates;
  final double? radius; // metros

  const Location({
    required this.placeId,
    required this.placeDescription,
    required this.coordinates,
    required this.radius,
  });

  Location copyWith({
    String? placeId,
    String? placeDescription,
    LatLng? coordinates,
    double? radius,
  }) {
    return Location(
      placeId: placeId ?? this.placeId,
      placeDescription: placeDescription ?? this.placeDescription,
      coordinates: coordinates ?? this.coordinates,
      radius: radius ?? this.radius,
    );
  }

  factory Location.fromPlaceCoordinates(
    PlaceCoordinates placeCoordinates, {
    double? radius,
  }) {
    return Location(
      placeId: placeCoordinates.id,
      placeDescription: placeCoordinates.description,
      coordinates: placeCoordinates.coordinates,
      radius: radius,
    );
  }
}
