import 'package:caregiver_hub/caregiver/screens/caregiver_filter_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_list_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_profile_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_recomendation_screen.dart';
import 'package:caregiver_hub/caregiver/services/caregiver_recomendation_service.dart';
import 'package:caregiver_hub/job/screens/job_description_screen.dart';
import 'package:caregiver_hub/job/screens/job_proposal_screen.dart';
import 'package:caregiver_hub/job/screens/job_list_screen.dart';
import 'package:caregiver_hub/job/services/job_service.dart';
import 'package:caregiver_hub/location/screens/place_picker_screen.dart';
import 'package:caregiver_hub/location/services/location_service.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:caregiver_hub/shared/services/caregiver_service.dart';
import 'package:caregiver_hub/shared/services/service_service.dart';
import 'package:caregiver_hub/shared/services/skill_service.dart';
import 'package:caregiver_hub/social/services/chat_service.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/user/screens/carregiver_form_screen.dart';
import 'package:caregiver_hub/user/screens/landing_screen.dart';
import 'package:caregiver_hub/user/screens/login_screen.dart';
import 'package:caregiver_hub/user/screens/profile_screen.dart';
import 'package:caregiver_hub/social/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getIt.registerLazySingleton<PlaceService>(() => PlaceService());
  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<ServiceService>(() => ServiceService());
  getIt.registerLazySingleton<SkillService>(() => SkillService());
  getIt.registerLazySingleton<CaregiverService>(() => CaregiverService());
  getIt.registerLazySingleton<ChatService>(() => ChatService());
  getIt.registerLazySingleton<JobService>(() => JobService());
  getIt.registerLazySingleton<CaregiverRecomendationService>(
    () => CaregiverRecomendationService(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AppStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CaregiverProvider(),
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
    final appStateProvider = Provider.of<AppStateProvider>(context);

    Widget homeWidget;
    if (appStateProvider.id.isEmpty) {
      homeWidget = const LandingScreen();
    } else if (appStateProvider.isCaregiver) {
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
        Routes.caregiverRecomendation: (_) => CaregiverRecomendationScreen(),

        // job
        Routes.jobDescription: (_) => const JobDescriptionScreen(),
        Routes.jobForm: (_) => const JobProposalScreen(),
        Routes.jobList: (_) => const JobListScreen(),

        // location
        Routes.placePicker: (context) => PlacePickerScreen(
              args: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>?,
            ),

        // user
        Routes.caregiverForm: (_) => CaregiverFormScreen(),
        Routes.landing: (_) => const LandingScreen(),
        Routes.login: (_) => const LoginScreen(),
        Routes.profile: (_) => ProfileScreen(),

        // social
        Routes.chat: (_) => ChatScreen(),
      },
    );
  }
}
