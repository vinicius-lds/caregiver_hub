import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String text;

  const ErrorState({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/error.png',
              width: 96,
              height: 96,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
