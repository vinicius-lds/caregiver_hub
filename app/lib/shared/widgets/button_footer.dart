import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonFooter extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final bool disabled;
  final void Function()? onPrimary;
  final void Function()? onSecondary;

  const ButtonFooter({
    Key? key,
    required this.primaryText,
    required this.secondaryText,
    required this.disabled,
    required this.onPrimary,
    required this.onSecondary,
  }) : super(key: key);

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
            onPressed: disabled ? null : onSecondary,
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
            onPressed: disabled ? null : onPrimary,
          ),
        ),
      ],
    );
  }
}
