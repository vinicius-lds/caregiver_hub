import 'package:caregiver_hub/ui/caregiver/signup/signup_screen.dart'
    as caregiversignupscreen;
import 'package:caregiver_hub/ui/employer/signup/signup_screen.dart'
    as employersignupscreen;
import 'package:caregiver_hub/ui/shared/constants/routes.dart';
import 'package:caregiver_hub/ui/shared/screens/landing_screen/landing_screen.dart';
import 'package:caregiver_hub/ui/shared/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // caregiver
        Routes.CAREGIVER_SIGNUP_SCREEN: (_) =>
            const caregiversignupscreen.SignupScreen(),

        // employer
        Routes.EMPLOYER_SIGNUP_SCREEN: (_) =>
            const employersignupscreen.SignupScreen(),

        // shared
        Routes.LANDING_SCREEN: (_) => const LandingScreen(),
        Routes.LOGIN_SCREEN: (_) => const LoginScreen(),
      },
    );
  }
}
