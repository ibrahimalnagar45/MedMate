 import 'package:midmate/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_locator.dart';

class SharedPrefrenceService {
  SharedPrefrenceService._();

  static final SharedPrefrenceService instance = SharedPrefrenceService._();
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

class SharedPrefrenceInstances {
  SharedPrefrenceInstances._();
 

  static UserModel userModel = getIt<UserModel>();
}

class SharedPrefrenceDb {
  static const String onBoardingVisited = 'onBoardingVisited';
  static const String user = 'User';
}
