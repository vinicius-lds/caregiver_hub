import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_card_data.dart';
import 'package:flutter/material.dart';

class CaregiverRecomendationItem extends StatelessWidget {
  final CaregiverRecomendationCardData caregiverRecomendation;

  const CaregiverRecomendationItem({
    Key? key,
    required this.caregiverRecomendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(caregiverRecomendation.employerImageURL),
      ),
      title: Text(caregiverRecomendation.employerName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StarRating(
            initialValue: caregiverRecomendation.rating.toDouble(),
            displayOnly: true,
          ),
          Text(
            caregiverRecomendation.recomendation,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
