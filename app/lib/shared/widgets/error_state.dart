import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String text;

  const ErrorState({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/images/error.png'),
          Text(text),
        ],
      ),
    );
  }
}
