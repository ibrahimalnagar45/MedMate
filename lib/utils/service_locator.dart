import 'package:get_it/get_it.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_prefrence_service.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final prefsService = SharedPrefrenceService.instance;

  await prefsService.init();
  getIt.registerSingleton<SharedPreferences>(prefsService.prefs);
  getIt.registerSingleton<UserModel>(UserModel.instance);
   
}
