import 'package:caregiver_hub/shared/models/location.dart';

class Place {
  final String id;
  final String description;

  const Place({
    required this.id,
    required this.description,
  });

  factory Place.fromLocation(Location location) {
    return Place(
      id: location.placeId,
      description: location.placeDescription,
    );
  }
}
