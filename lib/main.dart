import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/custom_bloc_observal.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/today_meds/doman/today_meds_repo.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'utils/app_fonts.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'utils/models/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await serviceLocatorSetup();
    Person? currentUser = await getIt<UserRepository>().getCurrentUser();
    getIt<TodayMedRepo>().getTodayMeds(currentUser!.id!).then((meds) {
      final now = DateTime.now();
      for (var med in meds) {
        if (med.nextTime!.isBefore(now)) {
          getIt<TodayMedRepo>().updateNextTime(med);
        }
      }
    });
    return Future.value(true);
  });
}

void main() async {
  await _initializeAppServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>(),
      child: MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const [
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
        theme: _buildTheme(),
        home: SplashView(),
      ),
    );
  }
}

Future<void> _initializeAppServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await serviceLocatorSetup();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  SqHelper();
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerOneOffTask("firt_task", "Update_Med_Dates");

  Bloc.observer = CustomBlocObserval();
  delelteEverthing();
}

ThemeData _buildTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.grey,
    fontFamily: AppFonts.primaryFont,
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.blue),
    ),
    primaryColor: AppColors.blue,
    iconTheme: const IconThemeData(color: AppColors.blue),
  );
}

void delelteEverthing() {
  Crud.instance.deleteAllMeds();
  Crud.instance.deleteAllusers();
  Crud.instance.closeMedsDb();
  Crud.instance.closeUsersDb();
  Crud.instance.deleteAllLogs();
  Crud.instance.closeLogsDb();
  Crud.instance.deleteMedsDatabaseFile();
  getIt<SharedPreferences>().clear();
}
