import 'package:caregiver_hub/employer/providers/caregiver_provider.dart';
import 'package:caregiver_hub/employer/screens/caregiver_list/caregiver_list_screen.dart';
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
        ChangeNotifierProvider(
          create: (ctx) => CaregiverProvider(),
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
          Routes.CAREGIVER_LIST: (_) => const CaregiverListScreen(),

          // shared
          Routes.LANDING_SCREEN: (_) => const LandingScreen(),
          Routes.LOGIN_SCREEN: (_) => const LoginScreen(),
          Routes.PROFILE_FORM_SCREEN: (_) => const ProfileFormScreen(),
        },
      ),
    );
  }
}
