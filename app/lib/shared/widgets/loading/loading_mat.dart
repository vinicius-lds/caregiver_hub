import 'package:flutter/material.dart';

class LoadingMat extends StatelessWidget {
  const LoadingMat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircularProgressIndicator.adaptive(),
        Text('Carregando...'),
      ],
    );
  }
}
