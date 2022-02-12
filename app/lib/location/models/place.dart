import 'package:caregiver_hub/location/models/place_coordinates.dart';

class Place {
  final String id;
  final String description;

  const Place({
    required this.id,
    required this.description,
  });

  factory Place.from(PlaceCoordinates placeCoordinates) {
    return Place(
      id: placeCoordinates.id,
      description: placeCoordinates.description,
    );
  }
}
