import 'dart:async';
import 'dart:convert';

import 'package:caregiver_hub/location/models/place.dart';
import 'package:caregiver_hub/location/models/place_coordinates.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class PlaceProvider with ChangeNotifier {
  Place? _selectedPlace;
  final StreamController<PlaceCoordinates?>
      _selectedPlaceCoordinatesStreamController = BehaviorSubject();

  Place? get selectedPlace {
    return _selectedPlace;
  }

  set selectedPlace(Place? value) {
    _selectedPlace = value;
    notifyListeners();
    _updateSelectedPlaceCoordinates();
  }

  StreamController<PlaceCoordinates?>
      get selectedPlaceCoordinatesStreamController {
    return _selectedPlaceCoordinatesStreamController;
  }

  _updateSelectedPlaceCoordinates() async {
    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/details/json',
      {
        'fields': 'geometry',
        'place_id': _selectedPlace!.id,
        'key': 'AIzaSyCmw_go04MwX36WMZDOb6XsvXGZLWTIda0',
      },
    );
    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    final location = body['result']['geometry']['location'];
    final coordinates = LatLng(location['lat'], location['lng']);
    if (_selectedPlace != null) {
      final placeCoordinates = PlaceCoordinates(
        id: _selectedPlace!.id,
        description: _selectedPlace!.description,
        coordinates: coordinates,
      );
      _selectedPlaceCoordinatesStreamController.add(placeCoordinates);
    }
  }
}
