import 'package:caregiver_hub/caregiver/providers/caregiver_recomendation_provider.dart';
import 'package:caregiver_hub/caregiver/providers/service_provider.dart';
import 'package:caregiver_hub/caregiver/providers/skill_provider.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_filter_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_list_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_profile_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_recomendation_screen.dart';
import 'package:caregiver_hub/job/providers/job_provider.dart';
import 'package:caregiver_hub/job/screens/job_description_screen.dart';
import 'package:caregiver_hub/job/screens/job_proposal_screen.dart';
import 'package:caregiver_hub/job/screens/job_list_screen.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/user/providers/user_provider.dart';
import 'package:caregiver_hub/user/screens/landing_screen.dart';
import 'package:caregiver_hub/user/screens/login_screen.dart';
import 'package:caregiver_hub/user/screens/profile_form_screen.dart';
import 'package:caregiver_hub/social/providers/chat_message_provider.dart';
import 'package:caregiver_hub/social/screens/chat_screen.dart';
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
          create: (ctx) => ServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SkillProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CaregiverRecomendationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => JobProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ChatMessageProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
      ],
      child: const _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  const _MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    Widget homeWidget;
    if (profileProvider.id.isEmpty) {
      homeWidget = const LandingScreen();
    } else if (profileProvider.isCaregiver) {
      homeWidget = const JobListScreen();
    } else {
      homeWidget = const CaregiverFilterScreen();
    }

    return MaterialApp(
      title: 'CaregiverHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeWidget,
      routes: {
        // caregiver
        Routes.caregiverFilter: (_) => const CaregiverFilterScreen(),
        Routes.caregiverList: (_) => const CaregiverListScreen(),
        Routes.caregiverProfile: (_) => const CaregiverProfileScreen(),
        Routes.caregiverRecomendation: (_) =>
            const CaregiverRecomendationScreen(),

        // job
        Routes.jobDescription: (_) => const JobDescriptionScreen(),
        Routes.jobForm: (_) => const JobProposalScreen(),
        Routes.jobList: (_) => const JobListScreen(),

        // shared
        Routes.landing: (_) => const LandingScreen(),
        Routes.login: (_) => const LoginScreen(),
        Routes.profile: (_) => const ProfileScreen(),

        // social
        Routes.chat: (_) => const ChatScreen(),
      },
    );
  }
}
