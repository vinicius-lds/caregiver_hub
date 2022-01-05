import 'package:flutter/material.dart';

class LoginScreenMat extends StatefulWidget {
  const LoginScreenMat({Key? key}) : super(key: key);

  @override
  _LoginScreenMatState createState() => _LoginScreenMatState();
}

class _LoginScreenMatState extends State<LoginScreenMat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Login'),
    );
  }
}
