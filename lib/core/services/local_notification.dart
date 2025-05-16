import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:midmate/features/notification/presentation/views/alaram_view.dart';
import 'package:midmate/features/notification/presentation/views/notification_view.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:android_intent_plus/android_intent.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final GlobalKey<NavigatorState> navigatorKey;

  LocalNotification({required this.navigatorKey});

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

    await requestExactAlarmsPermission();
    await requestNotificationPermission();
    await requestFullScreenIntent();
  }

  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }

    if (notificationResponse.payload == 'alarm_screen') {
      await Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute<void>(
          builder: (context) => AlaramView(payload: payload),
        ),
      );
      return;
    }

    await Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute<void>(
        builder: (context) => NotificationView(payload: payload),
      ),
    );
  }

  Future<void> showNotificationWithActions({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
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
            AndroidNotificationAction('id_3', 'Action 3'),
          ],
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      8,
      title,
      body,
      notificationDetails,
    );
  }

  showSceduledNotification({String? title, String? body, int? date}) async {
    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: date ??= 0)),

      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  showAlarmNotification({String? title, String? body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'alarm_channel_id',
          'Alarm Notifications',
          channelDescription: 'Channel for alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound('alram_sound'),
          icon: 'ic_notification', // your custom icon
          // ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      2, // fixed ID so you don't spam
      title,
      body,
      platformChannelSpecifics,
      payload: 'alarm_screen',
    );
  }

  showScheduledRepeatedNotification({
    String? title,
    String? body,
    required int id,
    required DateTime date,
  }) async {
    log('scheduled alarm notification called');

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'repeated_scheduled_alarm_channel_id',
          'Alarm Notifications',
          channelDescription: 'Channel for alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound('alram_sound'),
          icon: 'ic_notification', // your custom icon
          // ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
      id,
      title,
      body,
      Duration(hours: date.hour, minutes: date.minute, seconds: date.second),
      platformChannelSpecifics,
      payload: 'time_to_take_medicine',
    );
  }

  showSceduledAlarmNotification({
    String? title,
    String? body,
    required int date,
  }) async {
    log('scheduled alarm notification called');
    // log(date!.s)
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'scheduled_alarm_channel_id',
          'Alarm Notifications',
          channelDescription: 'Channel for alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound('alram_sound'),
          icon: 'ic_notification', // your custom icon
          // ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // await flutterLocalNotificationsPlugin.s
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: date)),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      payload: 'alarm_screen',
    );
  }

  cancleAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  cancleNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  getAllActiveNotification() async {
    final List<ActiveNotification> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    log('active  notifications: ${pendingNotificationRequests.first.title}');
  }

  getAllScheduledNotification() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    log('sheduled notifications:\n');

    for (var noti in pendingNotificationRequests) {
      log("noti id   ${noti.id}");
      log("noti title ${noti.title}");
    }
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

    log('Notification permission granted: $permission');
  }

  requestExactAlarmsPermission() async {
    final bool? permission =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .requestExactAlarmsPermission();

    // final intent = AndroidIntent(
    //   action: 'android.settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS',
    // );
    // intent.launch();
    while (!permission!) {
      // await flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //       AndroidFlutterLocalNotificationsPlugin
      //     >()!
      //     .requestExactAlarmsPermission();

      final intent = AndroidIntent(
        action: 'android.settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS',
      );
      intent.launch();
    }

    log('Exact alarms permission granted: $permission');
  }

  requestFullScreenIntent() async {
    final bool? permission =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .requestFullScreenIntentPermission();

    if (!permission!) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestFullScreenIntentPermission();
    }
    log('Full screen intent permission granted: $permission');
  }
}
