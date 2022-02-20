import 'package:flutter/material.dart';

class JobDetailActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Icon icon;
  final bool disabled;
  final void Function() onPressed;

  const JobDetailActionButton({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
    required this.disabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: icon,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 15 * textScaleFactor,
            ),
          ),
        ],
      ),
    );
  }
}
