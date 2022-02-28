import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final Color color;

  const EmptyState({
    Key? key,
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/nothing_found.png',
              color: color,
              width: 96,
              height: 96,
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
