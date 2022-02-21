import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_card_data.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/models/caregiver_recomendation_user_data.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';

class CaregiverRecomendationItem extends StatelessWidget {
  final UserService _userService = getIt<UserService>();

  final CaregiverRecomendationCardData caregiverRecomendation;

  CaregiverRecomendationItem({
    Key? key,
    required this.caregiverRecomendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CaregiverRecomendationUserData>(
        stream: _userService.fetchCaregiverRecomendationUserData(
          userId: caregiverRecomendation.employerId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          final userData =
              snapshot.data ?? CaregiverRecomendationUserData.empty();
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: userData.imageURL == null
                  ? const AssetImage(
                      'assets/images/user_profile_placeholder.png',
                    )
                  : NetworkImage(userData.imageURL!) as ImageProvider<Object>,
            ),
            title: Text(userData.name),
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
        });
  }
}
