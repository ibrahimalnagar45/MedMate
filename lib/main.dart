import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/splash/presentation/views/splash_view.dart';
import 'utils/app_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  // getIt<SharedPreferences>().clear();
  
  SqHelper();

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
      // home: AuthView(),
      home: SplashView(),
    );
  }
}
