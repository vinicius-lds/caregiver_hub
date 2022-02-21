import 'package:caregiver_hub/caregiver/widgets/caregiver_recomendation_item.dart';
import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_card_data.dart';
import 'package:caregiver_hub/caregiver/services/caregiver_recomendation_service.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';

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
  final _caregiverRecomendationService = getIt<CaregiverRecomendationService>();

  int _size = pageSize;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                StarRating(
                  initialValue: widget.rating,
                  displayOnly: true,
                ),
                StreamBuilder<List<CaregiverRecomendationCardData>>(
                  stream: _caregiverRecomendationService
                      .fetchCaregiverRecomendationCards(
                    caregiverId: widget.caregiverId,
                    size: _size,
                  ),
                  builder: (bContext, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loading();
                    }
                    if (!snapshot.hasData) {
                      return const EmptyState(text: 'Nenhuma avaliação');
                    }
                    final data =
                        snapshot.data as List<CaregiverRecomendationCardData>;
                    if (data.isEmpty) {
                      return const EmptyState(text: 'Nenhuma avaliação');
                    }
                    return Column(
                      children: [
                        ...data
                            .map(
                              (caregiverRecomendation) =>
                                  CaregiverRecomendationItem(
                                caregiverRecomendation: caregiverRecomendation,
                              ),
                            )
                            .toList(),
                        if (data.length == _size)
                          ElevatedButton(
                            child: Text(
                              'Carregar mais',
                              style: TextStyle(
                                fontSize: 15 * textScaleFactor,
                              ),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                            onPressed: () => setState(() => _size += pageSize),
                          )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
