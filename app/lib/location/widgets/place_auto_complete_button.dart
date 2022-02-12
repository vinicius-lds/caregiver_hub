import 'package:flutter/material.dart';

class PlaceAutoCompleteButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const PlaceAutoCompleteButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
