import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:android_intent_plus/android_intent.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static int id = 0;

  initializeDefaultNotificationSetting() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    // initializing setting for mac and ios
    // final DarwinInitializationSettings initializationSettingsDarwin =
    //     DarwinInitializationSettings();

    // initializing setting for linux
    // final LinuxInitializationSettings initializationSettingsLinux =
    //     LinuxInitializationSettings(
    //         defaultActionName: 'Open notification');

    // initializing setting for windows
    // final WindowsInitializationSettings initializationSettingsWindows =
    //     WindowsInitializationSettings(
    //         appName: 'Flutter Local Notifications Example',
    //         appUserModelId: 'Com.Dexterous.FlutterLocalNotificationsExample',
    //         // Search online for GUID generators to make your own
    //         guid: 'd49b0314-ee7a-4626-bf79-97cdb8a991bb');
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          // iOS: initializationSettingsDarwin,
          // macOS: initializationSettingsDarwin,
          // linux: initializationSettingsLinux,
          // windows: initializationSettingsWindows,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
    //  BuildContext context,

    // Function(String? payload) secondScreen,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }

    // uncomment this to navigate to the second screen when the notification is tapped

    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => secondScreen(payload)),
    // );
  }

  showNotification({String? title, String? body}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: 'ic_notification',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      title,
      body,
      notificationDetails,

      payload: 'item x',
    );
  }

  showSceduledNotification({
    String? title,
    String? body,
    DateTime? date,
  }) async {
    date!.second;
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.now(
        tz.local,
      ).add(Duration(days: date.day, hours: date.hour, seconds: date.second)),

      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // permission for android 13 and above
  requestNotificationPermission() async {
    final bool? permission =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .requestNotificationsPermission();

    if (!permission!) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();
    }
  }

  requestExactAlarmsPermission() async {
    final bool? permission =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .requestExactAlarmsPermission();

    while (!permission!) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestExactAlarmsPermission();
    }
    // if (!permission!) {
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin
    //       >()!
    //       .requestExactAlarmsPermission();
    //   // const intent = AndroidIntent(
    //   //   action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    //   // );
    //   // intent.launch();
    // }

    log('Exact alarms permission granted: $permission');
  }

  Future<void> showNotificationWithActions({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails
    androidNotificationDetails = AndroidNotificationDetails(
      '...',
      '...',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'id_1',
          'Action 1',
          //  showsUserInterface: true,
        ),
        AndroidNotificationAction(
          'id_2',
          'Action 2',
          // allowGeneratedReplies: true,
        ),
        AndroidNotificationAction(
          'id_3',
          'Action 3',
          // inputs: [
          //   AndroidNotificationActionInput(choices: ['Choice 1', 'Choice 2']),
          // ],
        ),
      ],
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      title,
      body,
      notificationDetails,
    );
  }
}
