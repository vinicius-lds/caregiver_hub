import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/screens/landing_screen/landing_screen.dart';
import 'package:caregiver_hub/shared/screens/login/login_screen.dart';
import 'package:caregiver_hub/shared/screens/profile_form/profile_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'CaregiverHub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          // caregiver

          // employer

          // shared
          Routes.LANDING_SCREEN: (_) => const LandingScreen(),
          Routes.LOGIN_SCREEN: (_) => const LoginScreen(),
          Routes.PROFILE_FORM_SCREEN: (_) => const ProfileFormScreen(),
        },
      ),
    );
  }
}
