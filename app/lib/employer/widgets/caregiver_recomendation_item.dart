import 'package:caregiver_hub/employer/widgets/star_rating.dart';
import 'package:caregiver_hub/employer/models/caregiver_recomendation.dart';
import 'package:flutter/material.dart';

class CaregiverRecomendationItem extends StatelessWidget {
  final CaregiverRecomendation caregiverRecomendation;

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
          StarRating(rating: caregiverRecomendation.rating.toDouble()),
          Text(
            caregiverRecomendation.recomendation,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
