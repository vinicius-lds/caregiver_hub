import 'package:flutter/material.dart';

class SignupScreenMat extends StatefulWidget {
  const SignupScreenMat({Key? key}) : super(key: key);

  @override
  _SignupScreenMatState createState() => _SignupScreenMatState();
}

class _SignupScreenMatState extends State<SignupScreenMat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Cadastrar Caregiver'),
    );
  }
}
