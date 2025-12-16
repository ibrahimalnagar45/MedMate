import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:midmate/core/managers/mode_cubit/mode_cubit.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/themes/app_bar_themes.dart';
import 'package:midmate/core/themes/icon_button_themes.dart';
import 'package:midmate/core/themes/icon_themes.dart';
import 'package:midmate/core/themes/switch_themes.dart';
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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ModeCubit()..getMode()),
        BlocProvider(create: (context) => getIt<UserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, ModeState>(
      builder: (context, state) {
        if (state is Modechanged) {
          return MaterialApp(
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
            theme:
                state.mode == 'light' ? _buildLightTheme() : _buildDarkTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: state.mode == 'light' ? ThemeMode.light : ThemeMode.dark,
            home: SplashView(),
          );
        }
        return MaterialApp(
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
          theme: _buildLightTheme(),
          themeMode: ThemeMode.light,
          home: SplashView(),
        );
      },
    );
  }
}

ThemeData _buildDarkTheme() {
  final base = ThemeData.dark();

  return base.copyWith(
    // 1️⃣ Text colors
    textTheme: base.textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
      decorationColor: Colors.black,
    ),
    primaryTextTheme: base.primaryTextTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),

    scaffoldBackgroundColor: AppColors.scaffoldDarkBgColor,
    primaryColor: AppColors.blue,
    appBarTheme: AppBarThemes.darkAppBarTheme,
    iconTheme: IconThemes.darkIconTheme,
    iconButtonTheme: IconButtonThemes.darkIconButtonTheme,
    switchTheme: AppSwitchTheme.darkSwitchTheme,
    // cardColor, dividerColor, bottomNavigationBarTheme, etc.
  );
}

ThemeData _buildLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldLightBgColor,
    fontFamily: AppFonts.primaryFont,
    iconButtonTheme: IconButtonThemes.lightIconButtonTheme,
    appBarTheme: AppBarThemes.ligthAppBarTheme,
    switchTheme: AppSwitchTheme.ligthSwitchTheme,
    primaryColor: AppColors.blue,
    iconTheme: IconThemes.lightIconTheme,
  );
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

  // delelteEverthing();
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
