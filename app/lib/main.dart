import 'package:caregiver_hub/caregiver/screens/caregiver_filter_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_list_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_profile_screen.dart';
import 'package:caregiver_hub/caregiver/screens/caregiver_recomendation_screen.dart';
import 'package:caregiver_hub/caregiver/services/caregiver_recomendation_service.dart';
import 'package:caregiver_hub/job/screens/job_description_screen.dart';
import 'package:caregiver_hub/job/screens/job_proposal_screen.dart';
import 'package:caregiver_hub/job/screens/job_list_screen.dart';
import 'package:caregiver_hub/job/services/job_service.dart';
import 'package:caregiver_hub/location/screens/location_screen.dart';
import 'package:caregiver_hub/location/services/location_service.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:caregiver_hub/shared/services/caregiver_service.dart';
import 'package:caregiver_hub/shared/services/notification_service.dart';
import 'package:caregiver_hub/shared/widgets/notifiable.dart';
import 'package:caregiver_hub/social/services/chat_service.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/user/screens/carregiver_form_screen.dart';
import 'package:caregiver_hub/user/screens/landing_screen.dart';
import 'package:caregiver_hub/user/screens/login_screen.dart';
import 'package:caregiver_hub/user/screens/profile_screen.dart';
import 'package:caregiver_hub/social/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';

final GetIt getIt = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  getIt.registerLazySingleton<PlaceService>(() => PlaceService());
  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<CaregiverService>(() => CaregiverService());
  getIt.registerLazySingleton<ChatService>(() => ChatService());
  getIt.registerLazySingleton<JobService>(() => JobService());
  getIt.registerLazySingleton<Geoflutterfire>(() => Geoflutterfire());
  getIt.registerLazySingleton<CaregiverRecomendationService>(
    () => CaregiverRecomendationService(),
  );
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());

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
      child: const _Router(),
    );
  }
}

class _Router extends StatefulWidget {
  const _Router({
    Key? key,
  }) : super(key: key);

  @override
  State<_Router> createState() => _RouterState();
}

class _RouterState extends State<_Router> {
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
      title: 'Caregiver Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Notifiable(homeWidget),
      navigatorKey: navigatorKey,
      navigatorObservers: [NavigationHistoryObserver()],
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
