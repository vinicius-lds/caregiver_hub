import 'dart:convert';

import 'package:caregiver_hub/shared/models/place.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const apiKey = 'AIzaSyCmw_go04MwX36WMZDOb6XsvXGZLWTIda0';

class PlaceService {
  Stream<List<Place>> placeAutoCompleteStream(final String input) {
    return Stream.fromFuture(
      http.get(
        Uri.https(
          'maps.googleapis.com',
          '/maps/api/place/autocomplete/json',
          {
            'input': input,
            'language': 'pt_BR',
            'key': apiKey,
          },
        ),
      ),
    ).map(
      (response) => (jsonDecode(response.body)['predictions'] as List)
          .map(
            (item) => Place(
              description: item['description'],
              id: item['place_id'],
            ),
          )
          .toList(),
    );
  }

  Future<PlaceCoordinates> toPlaceCoordinates(final Place place) async {
    return await handleHttpExceptions(() async {
      final uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/details/json',
        {
          'fields': 'geometry',
          'place_id': place.id,
          'key': apiKey,
        },
      );
      final response = await http.get(uri);
      final body = jsonDecode(response.body);
      final location = body['result']['geometry']['location'];
      final coordinates = LatLng(location['lat'], location['lng']);
      return PlaceCoordinates(
        id: place.id,
        description: place.description,
        coordinates: coordinates,
      );
    });
  }
}
