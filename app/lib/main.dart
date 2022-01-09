import 'package:caregiver_hub/employer/providers/caregiver_provider.dart';
import 'package:caregiver_hub/employer/providers/service_type_provider.dart';
import 'package:caregiver_hub/employer/providers/skill_type_provider.dart';
import 'package:caregiver_hub/employer/screens/caregiver_filter_screen.dart';
import 'package:caregiver_hub/employer/screens/caregiver_list_screen.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/screens/landing_screen.dart';
import 'package:caregiver_hub/shared/screens/login_screen_mat.dart';
import 'package:caregiver_hub/shared/screens/profile_form_screen.dart';
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
        ChangeNotifierProvider(
          create: (ctx) => ServiceTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SkillTypeProvider(),
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
          Routes.caregiverFilter: (_) => const CaregiverFilterScreen(),
          Routes.caregiverList: (_) => const CaregiverListScreen(),

          // shared
          Routes.landing: (_) => const LandingScreen(),
          Routes.login: (_) => const LoginScreen(),
          Routes.profileForm: (_) => const ProfileFormScreen(),
        },
      ),
    );
  }
}
