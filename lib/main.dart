import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/utils/models/shared_prefrence_db.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/splash/presentation/views/splash_view.dart';
import 'utils/app_fonts.dart';
import 'utils/services/shared_prefrence_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  SharedPreferences prefs = getIt<SharedPreferences>();
  prefs.setBool(SharedPrefrenceDb.onBoardingVisited, false);
  log(prefs.getBool(SharedPrefrenceDb.onBoardingVisited).toString());
  log(prefs.hashCode.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remind Me',
      theme: ThemeData(fontFamily: AppFonts.primaryFont),
      // home: HomeView()
      home: const SplashView(),
      // home: AuthView(),
    );
  }
}
