import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator.adaptive(),
        Text(
          'Carregando...',
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }
}
