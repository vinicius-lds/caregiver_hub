import 'package:caregiver_hub/location/models/place.dart';
import 'package:caregiver_hub/location/providers/place_provider.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceAutoCompleteBody extends StatelessWidget {
  final Function(Place)? onPlaceSelected;

  const PlaceAutoCompleteBody({
    Key? key,
    this.onPlaceSelected,
  }) : super(key: key);

  void _onPlaceSelected(BuildContext context, Place place) {
    if (onPlaceSelected != null) {
      onPlaceSelected!(place);
    }
    Provider.of<PlaceProvider>(context, listen: false).hideResults();
  }

  @override
  Widget build(BuildContext context) {
    PlaceProvider placeProvider = Provider.of<PlaceProvider>(context);
    if (!placeProvider.showingResults()) {
      return Container();
    }
    return StreamBuilder(
      stream: placeProvider.placeStream(),
      builder: (bContext, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Expanded(child: Loading());
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            (snapshot.data as List<Place>).isEmpty) {
          return const Expanded(
            child: EmptyState(text: 'Nenhum resultado encontrado'),
          );
        }
        final data = snapshot.data as List<Place>;
        return Expanded(
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
        );
      },
    );
  }
}
