import 'package:caregiver_hub/location/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceCoordinates extends Place {
  final LatLng coordinates;

  const PlaceCoordinates({
    required String id,
    required String description,
    required this.coordinates,
  }) : super(id: id, description: description);
}
