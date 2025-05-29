import 'package:get_it/get_it.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_prefrence_service.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorSetup() async {
  final prefsService = SharedPrefrenceService.instance;

  await prefsService.init();
  getIt.registerSingleton<SharedPreferences>(prefsService.prefs);
  getIt.registerLazySingleton<UserCubit>(() => UserCubit());
}

// getIt.registerLazySingleton<UserCubit>(() => UserCubit());
