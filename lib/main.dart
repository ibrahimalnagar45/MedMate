import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/custom_bloc_observal.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'utils/app_fonts.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
 

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
// final GlobalKey _buttonKey = GlobalKey();
// List<Person> users = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await serviceLocatorSetup();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
 
  // delelteEverthing();

  SqHelper();
  Bloc.observer = CustomBlocObserval();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>(),
      child: MaterialApp(
        locale: Locale('ar'),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Remind Me',
        theme: ThemeData(
          fontFamily: AppFonts.primaryFont,
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(foregroundColor: AppColors.blue),
          ),
          primaryColor: AppColors.blue,
          iconTheme: const IconThemeData(color: AppColors.blue),
        ),

        home: SplashView(),
      ),
    );
  }
}

// store the current user in sharedPreference
// create some fun to edit the current user, delete a user from sq db
void delelteEverthing() {
  Crud.instance.closeMedsDb();
  Crud.instance.closeUsersDb();
  Crud.instance.deleteAllMeds();
  Crud.instance.deleteAllusers();
  // Crud.instance.deleteMedsDatabaseFile();
  getIt<SharedPreferences>().clear();
}