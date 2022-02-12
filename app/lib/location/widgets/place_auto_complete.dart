import 'dart:convert';

import 'package:caregiver_hub/location/models/place.dart';
import 'package:caregiver_hub/location/providers/place_provider.dart';
import 'package:caregiver_hub/location/widgets/text_field_custom.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PlaceAutoComplete extends StatefulWidget {
  Place? initialPlace;
  VoidCallback onCancel;
  VoidCallback onConfirm;

  PlaceAutoComplete({
    Key? key,
    this.initialPlace,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<PlaceAutoComplete> createState() => _PlaceAutoCompleteState();
}

class _PlaceAutoCompleteState extends State<PlaceAutoComplete> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  Stream<List<Place>> _placeStream = const Stream.empty();
  bool _showResults = false;
  Place? _selectedPlace;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
    if (widget.initialPlace != null) {
      _controller.text = widget.initialPlace!.description;
      _selectedPlace = widget.initialPlace;
    }
  }

  void _onPlaceSelected(BuildContext context, Place place) {
    _controller.text = place.description;
    _focusNode.unfocus();
    setState(() {
      _showResults = false;
      _selectedPlace = place;
    });
    Provider.of<PlaceProvider>(context, listen: false).selectedPlace = place;
  }

  void _onSearchValueChanged(String? input) {
    // Ignora o evento emitido pela linha que seta o nome completo do lugar
    // no textField: _controller.text = place.description
    if (!_showResults && input == _selectedPlace?.description) {
      return;
    }
    setState(() {
      if (input == null || input.trim() == '') {
        _showResults = false;
      } else {
        _showResults = true;
        _placeStream = Stream.fromFuture(
          http.get(
            Uri.https(
              'maps.googleapis.com',
              '/maps/api/place/autocomplete/json',
              {
                'input': input,
                'language': 'pt_BR',
                'types': 'address',
                'key': 'AIzaSyCmw_go04MwX36WMZDOb6XsvXGZLWTIda0',
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
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    return Container(
      color: _showResults ? Colors.black45 : null,
      child: Column(
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
            child: Form(
              key: _formKey,
              child: TextFieldCustom(
                decoration: const InputDecoration(
                  hintText: 'Pesquise no Google Maps',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                ),
                controller: _controller,
                focusNode: _focusNode,
                debounce: 300,
                onChanged: _onSearchValueChanged,
              ),
            ),
          ),
          if (_showResults)
            StreamBuilder(
              stream: _placeStream,
              builder: (bContext, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Loading(
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    (snapshot.data as List<Place>).isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        EmptyState(
                          text: 'Nenhum resultado encontrado',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
                final data = snapshot.data as List<Place>;
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: data
                          .map(
                            (place) => InkWell(
                              onTap: () => _onPlaceSelected(context, place),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  place.description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          if (!_showResults)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _IconButtonCustom(
                        color: Colors.red,
                        icon: Icons.close,
                        onPressed: widget.onCancel,
                      ),
                      _IconButtonCustom(
                          color: Colors.green,
                          icon: Icons.check,
                          onPressed: widget.onConfirm),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _IconButtonCustom extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButtonCustom({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
