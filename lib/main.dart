import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:midmate/core/managers/language_cubit/language_cubit.dart';
import 'package:midmate/core/managers/mode_cubit/mode_cubit.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/themes/app_theme.dart';
import 'package:midmate/custom_bloc_observal.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:workmanager/workmanager.dart';
import 'core/services/background_service.dart';
import 'features/home/data/local_data_base/crud.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void main() async {
  await _initializeAppServices();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ModeCubit()..getMode()),
        BlocProvider(create: (context) => getIt<UserCubit>()),
        BlocProvider(create: (context) => getIt<LanguageCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ModeCubit>().state;
    final locale = context.watch<LanguageCubit>().state;
    log(locale.toString());
    // final isArabic =
    //     locale is LanguageChanged && locale.languageCode == 'ar' ? 'ar' : 'en';

    return MaterialApp(
      locale: locale,
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
          theme == AppThemeMode.light
              ? AppTheme.buildLightTheme()
              : AppTheme.buildDarkTheme(),
      darkTheme: AppTheme.buildDarkTheme(),
      themeMode: theme == AppThemeMode.light ? ThemeMode.light : ThemeMode.dark,
      home: SplashView(),
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
  Workmanager().registerOneOffTask("update_times_once", "Update_Med_Dates");

  Workmanager().registerPeriodicTask(
    "missed_check_daily",
    "daily_missed_check",
    frequency: const Duration(hours: 24),
  );

  Bloc.observer = CustomBlocObserval();

  // Crud.instance.delelteEverthing();
}
