import 'package:caregiver_hub/employer/models/caregiver.dart';
import 'package:caregiver_hub/employer/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaregiverListItem extends StatelessWidget {
  const CaregiverListItem({
    Key? key,
    required this.caregiver,
  }) : super(key: key);

  final Caregiver caregiver;

  String _buildPriceRangeString() {
    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');
    final startPriceRangeString = caregiver.startPriceRange == null
        ? null
        : formatter.format(caregiver.startPriceRange);
    final endPriceRangeString = caregiver.endPriceRange == null
        ? null
        : formatter.format(caregiver.endPriceRange);
    if (caregiver.startPriceRange == null && caregiver.endPriceRange == null) {
      return 'A negociar';
    } else if (caregiver.startPriceRange != null &&
        caregiver.endPriceRange != null) {
      return 'De $startPriceRangeString até $endPriceRangeString';
    } else if (caregiver.startPriceRange != null) {
      return 'A partir de $startPriceRangeString';
    } else {
      return 'Até $endPriceRangeString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(caregiver.imageURL),
          ),
          title: Text(caregiver.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _buildPriceRangeString(),
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
              StarRating(
                rating: caregiver.rating,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
