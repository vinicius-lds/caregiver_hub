import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaregiverPricing extends StatelessWidget {
  final double? startPrice;
  final double? endPrice;

  const CaregiverPricing({
    Key? key,
    this.startPrice,
    this.endPrice,
  }) : super(key: key);

  String _buildPriceRangeString() {
    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');
    final startPriceString =
        startPrice == null ? null : formatter.format(startPrice);
    final endPriceString = endPrice == null ? null : formatter.format(endPrice);
    if ((startPrice == null || startPrice == 0) &&
        (endPrice == null || endPrice == 0)) {
      return 'A negociar';
    } else if (startPrice != null &&
        startPrice != 0 &&
        endPrice != null &&
        endPrice != 0) {
      return 'De $startPriceString até $endPriceString';
    } else if (startPrice != null && startPrice != 0) {
      return 'A partir de $startPriceString';
    } else {
      return 'Até $endPriceString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _buildPriceRangeString(),
      style: const TextStyle(
        color: Colors.green,
      ),
    );
  }
}
