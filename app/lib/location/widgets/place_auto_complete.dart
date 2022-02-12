import 'package:caregiver_hub/shared/models/place.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/location/services/location_service.dart';
import 'package:caregiver_hub/location/widgets/place_auto_complete_button.dart';
import 'package:caregiver_hub/location/widgets/place_auto_complete_item.dart';
import 'package:caregiver_hub/location/widgets/text_field_custom.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';

class PlaceAutoComplete extends StatefulWidget {
  final bool readOnly;
  final Place? initialPlace;
  final void Function(PlaceCoordinates) onSelectedPlaceCoordinates;
  final VoidCallback onClear;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const PlaceAutoComplete({
    Key? key,
    required this.readOnly,
    required this.initialPlace,
    required this.onSelectedPlaceCoordinates,
    required this.onClear,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<PlaceAutoComplete> createState() => _PlaceAutoCompleteState();
}

class _PlaceAutoCompleteState extends State<PlaceAutoComplete> {
  final PlaceService placeService = getIt<PlaceService>();

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

  void _onPlaceSelected(BuildContext context, Place place) async {
    _controller.text = place.description;
    _focusNode.unfocus();
    setState(() {
      _showResults = false;
      _selectedPlace = place;
    });
    final placeCoordinates = await placeService.toPlaceCoordinates(place);
    widget.onSelectedPlaceCoordinates(placeCoordinates);
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
        _placeStream = placeService.placeAutoCompleteStream(input);
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
                readOnly: widget.readOnly,
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
                            (place) => PlaceAutoCompleteItem(
                              place: place,
                              onSelected: (place) =>
                                  _onPlaceSelected(context, place),
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
                      PlaceAutoCompleteButton(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.arrow_back_rounded,
                        onPressed: widget.onCancel,
                      ),
                      if (!widget.readOnly)
                        PlaceAutoCompleteButton(
                          color: Colors.red,
                          icon: Icons.close,
                          onPressed: widget.onClear,
                        ),
                      if (!widget.readOnly)
                        PlaceAutoCompleteButton(
                          color: Colors.green,
                          icon: Icons.check,
                          onPressed: widget.onConfirm,
                        ),
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
