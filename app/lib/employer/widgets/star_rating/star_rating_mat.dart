import 'package:flutter/material.dart';

class StarRatingMat extends StatelessWidget {
  const StarRatingMat({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  Widget _buildStar({required double factor}) {
    final IconData iconData;
    if (factor <= 0) {
      iconData = Icons.star;
    } else if (factor > 0 && factor < 1) {
      iconData = Icons.star_half;
    } else {
      iconData = Icons.star_border;
    }
    return Icon(iconData, color: Colors.yellow[600]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStar(factor: 1 - rating),
        _buildStar(factor: 2 - rating),
        _buildStar(factor: 3 - rating),
        _buildStar(factor: 4 - rating),
        _buildStar(factor: 5 - rating),
      ],
    );
  }
}
