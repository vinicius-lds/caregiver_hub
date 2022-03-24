import 'dart:convert';

import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/notification_type.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:caregiver_hub/shared/services/notification_service.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';

class Notifiable extends StatefulWidget {
  final Widget homeWidget;
  const Notifiable(this.homeWidget, {Key? key}) : super(key: key);

  @override
  State<Notifiable> createState() => _NotifiableState();
}

class _NotifiableState extends State<Notifiable> {
  final _notificationService = getIt<NotificationService>();

  @override
  void initState() {
    super.initState();

    _notificationService.initialize(
      (payload) => _handleMessage(jsonDecode(payload)),
    );

    FirebaseMessaging.instance.requestPermission().then((value) {});
    FirebaseMessaging.instance.getToken().then((token) {});
    FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {});

    // Pega a mensagem que foi recebida quando o app tava fechado e o usuário
    // clicou na notificação.
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('FirebaseMessaging.instance.getInitialMessage');
      if (message == null) {
        return;
      }
      _handleMessage(message.data);
    });

    // Só funciona quando o app está inicializado e em primeiro plano.
    FirebaseMessaging.onMessage.listen((message) {
      print('FirebaseMessaging.onMessage');
      if (message.notification != null) {
        if (navigatorKey.currentState != null &&
            message.data['type'] == NotificationType.chat.key &&
            NavigationHistoryObserver().top?.settings.name == Routes.chat) {
          return;
        }
        _notificationService.display(message);
      }
    });

    // Quando o usuário clica na notificação
    // O app tem que estar no backgroud e não fechado
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('FirebaseMessaging.onMessageOpenedApp');
      _handleMessage(message.data);
    });
  }

  void _handleMessage(Map<String, dynamic> data) async {
    final appStateProvider = Provider.of<AppStateProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );
    if (appStateProvider.id.isEmpty) {
      appStateProvider.registerPendingNotificationData(data);
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.login, (route) => false, // Remove todas as telas do stack
        arguments: {
          'fixedEmail': data['receiverEmail'],
        },
      );
    } else {
      final notificationRoute =
          await _notificationService.buildNotificationRoute(data);
      appStateProvider.isCaregiver =
          notificationRoute.receivedNotificationAsCaregiver;
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        notificationRoute.route,
        (route) => false, // Remove todas as telas do stack
        arguments: notificationRoute.arguments,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.homeWidget;
  }
}
