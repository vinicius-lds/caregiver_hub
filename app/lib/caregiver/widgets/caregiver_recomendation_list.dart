import 'package:caregiver_hub/caregiver/providers/caregiver_recomendation_provider.dart';
import 'package:caregiver_hub/caregiver/widgets/caregiver_recomendation_item.dart';
import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_card_data.dart';
import 'package:caregiver_hub/shared/widgets/button_footer.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverRecomendationList extends StatefulWidget {
  final String caregiverId;
  final double rating;

  const CaregiverRecomendationList({
    Key? key,
    required this.caregiverId,
    required this.rating,
  }) : super(key: key);

  @override
  State<CaregiverRecomendationList> createState() =>
      _CaregiverRecomendationListState();
}

class _CaregiverRecomendationListState
    extends State<CaregiverRecomendationList> {
  int _offset = 0;
  final int _size = 5;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final caregiverRecomendationProvider =
        Provider.of<CaregiverRecomendationProvider>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Avaliações',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18 * textScaleFactor,
              ),
            ),
          ),
          StreamBuilder<int>(
            stream: caregiverRecomendationProvider.countStream(
              caregiverId: widget.caregiverId,
            ),
            builder: (bContext, snapshot) {
              int count;
              if (snapshot.connectionState != ConnectionState.done ||
                  !snapshot.hasData) {
                count = 0;
              } else {
                count = snapshot.data!;
              }
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StarRating(
                          initialValue: widget.rating,
                          displayOnly: true,
                        ),
                        Text(
                          '$count avaliações',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder<List<CaregiverRecomendationCardData>>(
                      stream: caregiverRecomendationProvider.cardDataListStream(
                        caregiverId: widget.caregiverId,
                        offset: _offset,
                        size: _size,
                      ),
                      builder: (bContext, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Loading();
                        }
                        if (!snapshot.hasData) {
                          return const EmptyState(text: 'Nenhuma avaliação');
                        }
                        final data = snapshot.data
                            as List<CaregiverRecomendationCardData>;
                        if (data.isEmpty) {
                          return const EmptyState(text: 'Nenhuma avaliação');
                        }
                        return Column(
                          children: [
                            ...data
                                .map(
                                  (caregiverRecomendation) =>
                                      CaregiverRecomendationItem(
                                    caregiverRecomendation:
                                        caregiverRecomendation,
                                  ),
                                )
                                .toList(),
                            ButtonFooter(
                              primaryText: 'Próximo',
                              secondaryText: 'Anterior',
                              onPrimary: (_offset + 1) * _size > count
                                  ? null
                                  : () => setState(() => _offset++),
                              onSecondary: _offset == 0
                                  ? null
                                  : () => setState(() => _offset--),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
