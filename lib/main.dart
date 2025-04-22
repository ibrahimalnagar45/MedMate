import 'package:flutter/material.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'utils/app_fonts.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

 
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  // tz.setLocalLocation(tz.getLocation(timeZoneName));
  // // getIt<SharedPreferences>().clear();
  // await LocalNotification().requestNotificationPermission();
  // await LocalNotification().requestExactAlarmsPermission();

  await LocalNotification(
    navigatorKey: navigatorKey,
  ).initializeDefaultNotificationSetting();

  SqHelper();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Remind Me',

      theme: ThemeData(
        fontFamily: AppFonts.primaryFont,
        primaryColor: AppColors.blue,
        iconTheme: const IconThemeData(color: AppColors.blue),
      ),
      // home: HomeView()
      // home: AuthView(),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: SplashView(),
      ),
    );
  }
}

/**
 * i should use { requestExactAlarmsPermission()}

 this doc to user full screen alram https://pub.dev/packages/flutter_local_notifications#full-screen-intent-notifications

showsUserInterface  to get ontaped notification to open the app

 */
 