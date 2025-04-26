import 'package:flutter/material.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'utils/app_fonts.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  // tz.setLocalLocation(tz.getLocation(timeZoneName));
  // getIt<SharedPreferences>().clear();
  // await deleteDatabase(path);

  // Crud.instance.deleteAll();
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

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
        
        // Add more locales
      ],

      /**
       
supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale('en'), 
       */
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Remind Me',

      theme: ThemeData(
        fontFamily: AppFonts.primaryFont,
        primaryColor: AppColors.blue,
        iconTheme: const IconThemeData(color: AppColors.blue),
      ),

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
