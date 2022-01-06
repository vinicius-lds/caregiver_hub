import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormButtonFooterMat extends StatelessWidget {
  const FormButtonFooterMat({
    Key? key,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimary,
    required this.onSecondary,
  }) : super(key: key);

  final String primaryText;
  final String secondaryText;
  final void Function() onPrimary;
  final void Function() onSecondary;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: ElevatedButton(
            child: Text(
              secondaryText,
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
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.grey,
              ),
            ),
            onPressed: onSecondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: ElevatedButton(
            child: Text(
              primaryText,
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
            onPressed: onPrimary,
          ),
        ),
      ],
    );
  }
}
