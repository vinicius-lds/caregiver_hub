import 'package:caregiver_hub/location/models/place.dart';
import 'package:caregiver_hub/location/providers/place_provider.dart';
import 'package:caregiver_hub/location/widgets/place_auto_complete_body.dart';
import 'package:caregiver_hub/location/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceAutoComplete extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  PlaceAutoComplete({
    Key? key,
  }) : super(key: key);

  void _onPlaceSelected(Place place) {
    print('place: ${place.description}');
    _controller.text = place.description;
  }

  void _onSearchValueChanged(BuildContext context, String? searchValue) {
    Provider.of<PlaceProvider>(context, listen: false)
        .placeSearch(searchValue ?? '');
    if (searchValue != null && searchValue.trim() != '') {
      Provider.of<PlaceProvider>(context, listen: false).showResults();
    } else {
      Provider.of<PlaceProvider>(context, listen: false).hideResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: viewPadding.top * 1.5,
            left: viewPadding.top * 0.5,
            right: viewPadding.top * 0.5,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: TextFieldCustom(
            decoration: const InputDecoration(
              hintText: 'Pesquise no Google Maps',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
            ),
            controller: _controller,
            debounce: 300,
            onChange: (value) => _onSearchValueChanged(context, value),
          ),
        ),
        PlaceAutoCompleteBody(onPlaceSelected: _onPlaceSelected),
      ],
    );
  }
}
