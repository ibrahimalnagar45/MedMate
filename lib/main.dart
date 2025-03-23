import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/features/user_data/presentation/views/user_data_view.dart';
import 'package:midmate/utils/models/shared_prefrence_db.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/app_fonts.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  SharedPreferences prefs = getIt<SharedPreferences>();
  prefs.setBool(SharedPrefrenceDb.onBoardingVisited, false);

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
      home: UserDataView(),
    );
  }
}
