import 'dart:convert';

import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/notification.dart';
import 'package:caregiver_hub/shared/models/notification_route.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:caregiver_hub/job/services/job_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _firestore = FirebaseFirestore.instance;
  final _userService = getIt<UserService>();
  final _jobService = getIt<JobService>();
  final _plugin = FlutterLocalNotificationsPlugin();

  void initialize(Function(String) handler) {
    _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        ),
      ),
      onSelectNotification: (payload) {
        if (payload != null) {
          handler(payload);
        }
      },
    );
  }

  Future<void> pushNotification(Notification notification) async {
    await handleFirebaseExceptions(() async {
      final receiverEmail =
          await _userService.fetchEmail(userId: notification.toUserId);
      final notificationMap = notification.toMap();
      notificationMap['data']['receiverEmail'] = receiverEmail;
      await _firestore.collection('notifications').add(notificationMap);
    });
  }

  void display(RemoteMessage message) async {
    if (message.notification == null) {
      return;
    }

    final notification = message.notification!;
    final id = DateTime.now().millisecond;

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'caregiver_hub_notification_channel', // channel id
        'caregiver_hub_notification_channel', // channel name
        channelDescription:
            'This channel is used for caregiver hub notifications.',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    );

    await _plugin.show(
      id,
      notification.title,
      notification.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  Future<NotificationRoute> buildNotificationRoute(
    Map<String, dynamic> data,
  ) async {
    final String type = data['type'];
    final receivedNotificationAsCaregiver =
        'true' == data['receivedNotificationAsCaregiver'].toLowerCase();
    if (type == 'CHAT') {
      final otherUserId = data['otherUserId'];
      final userChatData =
          await _userService.fetchOtherUserChatData(otherUserId);
      return NotificationRoute(
        route: Routes.chat,
        receivedNotificationAsCaregiver: receivedNotificationAsCaregiver,
        arguments: userChatData.toMap(),
      );
    } else if (type == 'JOB_CHANGE') {
      final otherUserId = data['otherUserId'];
      final jobId = data['jobId'];
      final jobUserData =
          await _userService.fetchJobUserData(userId: otherUserId).first;
      final job = await _jobService.fetchJob(id: jobId);

      return NotificationRoute(
        route: Routes.jobDescription,
        receivedNotificationAsCaregiver: receivedNotificationAsCaregiver,
        arguments: {
          'job': job,
          'jobUserData': jobUserData,
        },
      );
    } else {
      throw ServiceException(
        'Can\'t build notification route for message of type "$type".',
      );
    }
  }
}
