import 'package:caregiver_hub/location/models/place.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceProvider with ChangeNotifier {
  Stream<List<Place>> _placeStream = const Stream.empty();
  bool _showingResults = false;
  String? _lastSearch;

  Stream<List<Place>> placeStream() {
    return _placeStream;
  }

  bool showingResults() {
    return _showingResults;
  }

  void showResults() {
    _showingResults = true;
    notifyListeners();
  }

  void hideResults() {
    _showingResults = false;
    notifyListeners();
  }

  void _teste(String? input) async {
    final result = await http.get(
      Uri.https(
        'maps.googleapis.com',
        '/maps/api/place/autocomplete/json',
        {
          'input': input,
          'language': 'pt_BR',
          'types': 'geocode',
          'key': 'AIzaSyCmw_go04MwX36WMZDOb6XsvXGZLWTIda0',
        },
      ),
    );
    print('result');
    print(result.body);
  }

  void placeSearch(String input) {
    if (_lastSearch == input) {
      return;
    }
    _lastSearch = input;

    print('Making request');

    // _teste(input);

    // https://maps.googleapis.com/maps/api/place/autocomplete/json?input=INPUT&language=pt_BR&types=geocode&key=API_KEY
    _placeStream = Stream.fromFuture(
      http.get(
        Uri.https(
          'maps.googleapis.com',
          '/maps/api/place/autocomplete/json',
          {
            'input': input,
            'language': 'pt_BR',
            'types': 'geocode',
            'key': 'AIzaSyCmw_go04MwX36WMZDOb6XsvXGZLWTIda0',
          },
        ),
      ),
    ).map(
      (response) => (jsonDecode(response.body)['predictions'] as List)
          .map(
            (e) => Place(
              description: e['description'],
              id: e['place_id'],
            ),
          )
          .toList(),
    );
    // notifyListeners();
  }
}
