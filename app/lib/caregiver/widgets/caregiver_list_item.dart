import 'package:caregiver_hub/caregiver/widgets/caregiver_pricing.dart';
import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:flutter/material.dart';

class CaregiverListItem extends StatelessWidget {
  const CaregiverListItem({
    Key? key,
    required this.caregiver,
  }) : super(key: key);

  final Caregiver caregiver;

  void _pushCaregiverProfileScreen(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.caregiverProfile,
        arguments: {'caregiver': caregiver});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _pushCaregiverProfileScreen(context),
        child: ListTile(
          leading: Hero(
            tag: caregiver.id,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: caregiver.imageURL == null
                  ? const AssetImage(
                      'assets/images/user_profile_placeholder.png',
                    )
                  : NetworkImage(caregiver.imageURL!) as ImageProvider<Object>,
            ),
          ),
          title: Text(caregiver.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CaregiverPricing(
                startPrice: caregiver.startPrice,
                endPrice: caregiver.endPrice,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: StarRating(
                  initialValue: caregiver.rating,
                  displayOnly: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
