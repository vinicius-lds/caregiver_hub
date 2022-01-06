import 'package:caregiver_hub/employer/widgets/star_rating/star_rating_mat.dart';
import 'package:flutter/widgets.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return StarRatingMat(
      rating: rating,
    );
  }
}
